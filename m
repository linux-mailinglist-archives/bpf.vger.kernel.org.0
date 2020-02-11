Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B67159A1F
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 21:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgBKUBt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 15:01:49 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:36620 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgBKUBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 15:01:49 -0500
Received: by mail-qk1-f173.google.com with SMTP id w25so11447272qki.3
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2020 12:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzpfR9c0DsHuA8mYbizuDA8A02cmDQa3jdXsDnav/yo=;
        b=qkYcgBWCqxmndxAhuf9olS2fk0srg2n6AJ5eQK2F87RChfkNLv2Pxk/CvAv/k0Kajo
         uWQ/UBlPYS/1GZMWhobkITLmLjR7RLx6SFjm5Vr9s+BPNm4Xb9nTLyMy4+SgJqKU6rku
         Ti+5sqOiD9STlljqjJwB5nsq0o6CRCRQtZR22QkEOSr6d7pmDwWkcczZMUiO1FDpiwAZ
         SRnnzLn3rI1KYgBze+EwZcyACjzSgjP5shhQoWGm/afqMzNKyIVmjBfoslEVd3Lcu7AP
         gd7VBv/ijXpo4B8doNyXyHXpeXFkw8Rf8oiNhV3F6M3NBv7nnuV6sMEfjiMkqNj0JzUc
         3bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzpfR9c0DsHuA8mYbizuDA8A02cmDQa3jdXsDnav/yo=;
        b=KogGKCNwrcB6f74A00GichVAm6SMSaNoWSVIuGaVhH5H4eLIO6/d9H+EhrStz6fu0N
         N6wuHC9k9H9IouwaogMJx9mGFimFYbYiikHwDH53pnrqRU/NBEE4CBTIeCeFBd7f3w5v
         opoy5Xsi3oXFJ2W+0IiZxX+Zzd28gKy+OozCmqg+YQEFKS2qHbpDyjGsS/6DGnoUtJ8x
         bO/Nbhu8+RBUJihrCthygBCrU9iWY/K+crk92pOvgE8H2hOrRLUIxHCOU5HzoQzl9rs2
         amo1BDFw2K99HSb0eKQO81lDL1biBVaTlDq+lssmwTjmObtg1nsDEXYAGfMZ9znS75rj
         py/A==
X-Gm-Message-State: APjAAAVQl8M0ae5LCrGgZyqbh5jPuXj8sjdh0byvix2P3nHQBLSGNHF8
        NeUFALYvBAvOfi9tS886viBhrEgGIC+NCvsRX1h+Wg==
X-Google-Smtp-Source: APXvYqyc25slMcnyJh97nHtGnTSJXzyz3f5QXwB+nGahx6vK32xIr5LBIp6pn+IU/qsG/WfET0+rQ544RIoa9w0bOB4=
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr7829004qkg.39.1581451308364;
 Tue, 11 Feb 2020 12:01:48 -0800 (PST)
MIME-Version: 1.0
References: <CAKRbtyV6jSDjXAjViJTm9frCcR83UijDRobFTRcfjNU9z_APdA@mail.gmail.com>
In-Reply-To: <CAKRbtyV6jSDjXAjViJTm9frCcR83UijDRobFTRcfjNU9z_APdA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 Feb 2020 12:01:37 -0800
Message-ID: <CAEf4BzZWUtfn_jMs7xDowj40skGjd8XFVefn1DWth=8-AR0Bqg@mail.gmail.com>
Subject: Re: Bugs with libbpf
To:     Benjamin Nilsen <bcnilsen@ucdavis.edu>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 14, 2020 at 10:35 PM Benjamin Nilsen <bcnilsen@ucdavis.edu> wrote:
>
> Hello,
>
> I believe I found some bugs with libbpf and just wanted to share them here.
> I have attached them below.
>
> Regards,
> Ben
>
>
> The first one:
> I believe there is an error with: libbpf_nla_dump_errormsg();
>
> The second one:
> libbpf_nla_parse();

Can you please expand on what the bugs are, specifically? It will help
direct libbpf developer's attention to fixing bugs, thanks.

>
> Third one:
> I believe there is a stack buffer overflow with the method
> bpf_object__open_buffer() when running the attached program with the
> input:
> ./LibbpfTest15.c (executable version) LibbpfTest15buginput LibbpfTest15buginput

Yyou code calls bpf_object__load() unconditionally, even if
bpf_object__open_buffer fails (which it obviously does in this case,
as you are giving it a random 5 bytes as an ELF file). Again, there
might be bugs, but please be more specific.
