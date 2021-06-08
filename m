Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084EC39F485
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 13:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhFHLFP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 07:05:15 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:45940 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhFHLFP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 07:05:15 -0400
Received: by mail-yb1-f169.google.com with SMTP id g38so29539094ybi.12
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rlvUoDN9yc/zMTIo/KYEfU7FFB0Fqdn4J0EeD0WqhV0=;
        b=Yb9TZyz+ZAhopsM7qeh2hVGTjR9mvypFx6LMSCI74bk3D8Xf5FDvyWftwZXT7MZTg/
         Wz/rznAWRbEcFVUrInl79yh/+cwdGqwTQ4OWFjjCAVOQnPs+fanD1tThhX1UcxsZ3Nfq
         Vm+r1gnDQ80hkZ1gnzJtV78i4TdyJyw6ga0QG8VRIbyjSlro1IJJF9zrIUqA57uCjDnu
         RrbFhr/5bGun0gobYE2OQFY38QunJZmu8ibqvaoQNgobFArPI9jA8lUehIoLtwcLbXiI
         n3jUWrIwFXIUocRCHKDre+jly4CIc+mUg9KMOo0cyiKqFbeQSuITFJdtgCUBhcqBVXOI
         PeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rlvUoDN9yc/zMTIo/KYEfU7FFB0Fqdn4J0EeD0WqhV0=;
        b=gcIyXifksY6QXXC7CtsJDM3ohIHbQjRvOP6APCc0yew/6T7LHm4B4rDq4VJYQjbbMU
         iZJHdBje44O4s+3ZvR7kLUsHH55GPE+G7p4LGUlCO3FTFYdakbe9xXe/2+BFenkuN8zo
         q0GlSpdxVSrC2OWvuporfp4s9ndOOg3udIvG8VjgVTR/FEWYgvIr4bwvZyDDWdqV2oif
         16xaX6nMpskPmCm/LrByc6GZfD3w0li2TnYY7ne9BpWYJ9ZaR1hK18vFq70NM+9PwbCs
         wgxN3Habg5BsuNCLtwL2+aX7wkWFhdK8fiKH245u87S/c/OyEg+jIbk21stteC3jKUZT
         LXlQ==
X-Gm-Message-State: AOAM530ExhCLNcDNuD96F4jHJfnnZglO5e9ZAIUzKZ0hEXpu0FMqzC0M
        ySugwt49ScvCfKUbt8rD+377CvdWD1QaVlQoaSmavlF/101nkdPf
X-Google-Smtp-Source: ABdhPJxmNpnaciyHPz+z+GailtH3HcBCPPNhHqehS2+EZBKH+ScyXRDfCiOdnizBflujhS7q9USdwFspNfyrlupfnbs=
X-Received: by 2002:a25:888b:: with SMTP id d11mr32905375ybl.385.1623150128021;
 Tue, 08 Jun 2021 04:02:08 -0700 (PDT)
MIME-Version: 1.0
From:   rainkin <rainkin1993@gmail.com>
Date:   Tue, 8 Jun 2021 19:01:32 +0800
Message-ID: <CAHb-xaum8ftH1kWktSh6NZ_z0ZrBNqG9Rchs+68ePHOwq31dBQ@mail.gmail.com>
Subject: How to get the updated content of an argument which is updated in a
 kernel function by kprobe
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
Assume that a kernel function has an input argument (i.e., a pointer),
and the function will update the content pointed by the pointer during
execution. My question is how to get the updated content using kprobe.

Take the kernel function path_lookupat as example:
static int path_lookupat(struct nameidata *nd, unsigned flags, struct
path *path)
It lookup the path according to a given file name and store the
founded path in the third input arguments (i.e., struct path *path).

My goal is to get the founded path from the third input argument.

I attach my ebpf program to this kernel function using kprobe, and try
to print the content of the path argument. However, the content is
empty, which is reasonable because the function has not beed executed.
The following is the code:

SEC("kprobe/path_lookupat")
int BPF_KPROBE(path_lookupat, struct nameidata *nd, unsigned flags,
struct path *path)
{
    char fn[127];
    const unsigned char *fn_ptr = BPF_CORE_READ(path, dentry, d_name.name);
     bpf_core_read_str(fn, sizeof(fn), fn_ptr);
     bpf_printk("path_lookupat: %s\n", fn);
     return 0;
}

Then I try to do that by kretprobe where the function has been
executed, but it seems that I cannot get the input arguments in
kretprobe.

Do you have any ideas or suggestions to do that?
Thanks,
rainkin
