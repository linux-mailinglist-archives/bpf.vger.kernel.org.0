Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF73B71A0
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2019 04:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfISClm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Sep 2019 22:41:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43634 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbfISClm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Sep 2019 22:41:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id t84so1390425oih.10
        for <bpf@vger.kernel.org>; Wed, 18 Sep 2019 19:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zF2qMJhxuQ7amM744y+ks2XfHt5ik/9ezksZyHoMiSU=;
        b=ELpEwWid+4qlSD34uVmhArCa/CyRJZ2W/ET6T6iEapIjYfvkOQegVRurqSJWsY4yx7
         4eTyl+ojM6L/nV6sWwIpX+g3xFpwHDLM+2wMJzIMnABiDk6SLSydfNiVEvCn5feRLsUD
         BWOSvWTK6JQ1jq+zFr0I4iLUGFYdKNQyL/bRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zF2qMJhxuQ7amM744y+ks2XfHt5ik/9ezksZyHoMiSU=;
        b=aoL/QcDzmBzCmk4mB4/94jyrV3Vz66ucf6cKSFscUEzds/rIHmX1zHJZtGFLzK8V3v
         Zzt/BKhSEmg7TBw+b2JjsNGrVIkmJ9Ck7tww4RJZU2P3CbKMw6fz+NYm45iYEJOLRkKH
         C8UjbypIWE7Wp1nmIjxxwK6RvrIJUn/aagILBPI8w7DSrNRGfRINFuLrwPKWdMKaeSsj
         NXoFlFcBk8JtgIkK5YcnPQVZzdjQku2Bev1eS4oGrhY8YpfqjTCsFf2Og/lFBpPqBIW3
         bBaOmYbKe2dc3bzaPeHxQGjRmxXpxPP+zSLsxDIhB3VmHiYEL4xHvM2Tr38un8HeSmgO
         oiYQ==
X-Gm-Message-State: APjAAAUWsAfsDpj7tMyzbPB1TcEI3+RNFoBTdq7qm2tPLOeqF/I7rW02
        4fm42yjBVLP0HJzgM0n+CQYesyAAStRtb0ZWMtcX+A==
X-Google-Smtp-Source: APXvYqwdY67w0gNkFtbnj1bH3iAl2vo2pajLL/nDexd1Q7O0s3eRABmc/mRXydNW0s4t7KX8nU8wmQkZ08j2NeirkBc=
X-Received: by 2002:aca:d708:: with SMTP id o8mr701338oig.68.1568860900916;
 Wed, 18 Sep 2019 19:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190918052406.21385-1-jinshan.xiong@gmail.com>
 <5302836c-a6a1-c160-2de2-6a5b3d2c4828@fb.com> <20190918143235.kpclo45eo7qye7fs@ast-mbp.dhcp.thefacebook.com>
 <CA+-8EHRk6aAuDQ=S9O7h6T2fhyz2z+zQduN2yiDNWMOWt2-t_A@mail.gmail.com> <CAADnVQLsnFaFS+ZhRoL0QfDVcGiR2OSrqSqRsd5dci=rQ+Pb9A@mail.gmail.com>
In-Reply-To: <CAADnVQLsnFaFS+ZhRoL0QfDVcGiR2OSrqSqRsd5dci=rQ+Pb9A@mail.gmail.com>
From:   Jinshan Xiong <jinshan.xiong@uber.com>
Date:   Wed, 18 Sep 2019 19:41:29 -0700
Message-ID: <CA+-8EHRHTUPNJEwT_wb+O-CStvCoT2=U4h=0JqB6mXfzBArbvQ@mail.gmail.com>
Subject: Re: [PATCH] staging: tracing/kprobe: filter kprobe based perf event
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        "jinshan.xiong@gmail.com" <jinshan.xiong@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

That's bloody true. Thanks for your insights.

I will make an example program and commit into bcc repository.

Jinshan


On Wed, Sep 18, 2019 at 1:22 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 18, 2019 at 8:13 AM Jinshan Xiong <jinshan.xiong@uber.com> wr=
ote:
> >
> > The problem with the current approach is that it would be difficult to =
filter cgroup, especially the cgroup in question has descendents, and also =
it would spawn new descendents after BPF program is installed. it's hard to=
 filter it inside a BPF program.
>
> Why is that?
> bpf_current_task_under_cgroup() fits exactly that purpose.
