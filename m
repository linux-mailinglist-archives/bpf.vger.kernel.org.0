Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60062699B3D
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 18:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjBPRZd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 12:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjBPRZc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 12:25:32 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C594D601
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 09:25:32 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id ml1-20020a17090b360100b00234686df48fso1281349pjb.8
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 09:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0iou2++YEQDKVGhVL15VyuW+0n7zlQrFIqzvPbS1rE=;
        b=qyO+47alZfU3NjjhaKpPnF37UFumUmf1tFEG3zC24mQv/+3aIMh7lPBdMUlTGc/+3M
         WBy1FUiLVMhV4Jrjz99PI+AMulbnFY+Tc5m3nUI1euXKmAUNas6sSYqeYRtQHK9sYYZR
         qbhhf7gN6NXF9/8y6+b+ilaHYB6lyWI1dMPMQrz5XMbNTBymMBAhW114N7ES9sK9GYZe
         PeRbqMsiQJwNzo2gI1IYql4hvq9PlGVGnZ4GDvimaFY34X2EjoCPIj+4O84oaDqM7e82
         Aw9EZrYEsDxTuMfSByLGbS1qVUK7ki3rMdGVlMt4zYpXXvsp1LRj2jqehV7bJNQML6YZ
         pMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0iou2++YEQDKVGhVL15VyuW+0n7zlQrFIqzvPbS1rE=;
        b=UitsMOgY0tqSy7s8VZ+fiwwwURb8GJA/Qk9a/H0rKU4oIAAZ7K043GrWvAhybpk9aV
         pQ6VAwvdqQqvWtMbWJBy05P7QWRDxQXHSzKPJ5c0T6ryoaRn4AC3itxKjkbj3XUW82n6
         75n/WnALhI/VS+fhyjRYIOwlYa/We/XWyfzthJFEs2qgsFN8MHXXyrtRJ19u1IQieFQG
         4X3ZLVhDX4VlpGa61JBby6+SqdJXJwj9b79Ttfa885yldtoVOq9+CviTVEj2+y+lGbKj
         yGeNmpyC2vONOPJH3ELuk9POgOlljz7TsW8ppa2iPefiPGamAPPg7aJmatGiRkWI+mVr
         GW4Q==
X-Gm-Message-State: AO0yUKVbq461FM4Eb6CyLhw7/NuTNNJyti3NKfwOnL9GFUcWcKb5W27W
        8vLlEkVUBiqX1OEujTAXquEWKkM=
X-Google-Smtp-Source: AK7set+JpfiVVGRIBizgOkyrEvCWd/KhxpGjotWthsD17XQRHGlefGSt3AIgXvNe7a+Qz5C16FSUnIk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3684:0:b0:4fb:5f4b:f5cf with SMTP id
 d126-20020a633684000000b004fb5f4bf5cfmr966843pga.3.1676568331051; Thu, 16 Feb
 2023 09:25:31 -0800 (PST)
Date:   Thu, 16 Feb 2023 09:25:29 -0800
In-Reply-To: <CAADnVQK-_MOk=ejM5USFZL9codbzosUqfAs4ppqQuC0y4uBLqw@mail.gmail.com>
Mime-Version: 1.0
References: <20230215235931.380197-1-iii@linux.ibm.com> <20230215235931.380197-2-iii@linux.ibm.com>
 <CAADnVQK-_MOk=ejM5USFZL9codbzosUqfAs4ppqQuC0y4uBLqw@mail.gmail.com>
Message-ID: <Y+5nCRZ3ns3u+Tun@google.com>
Subject: Re: [PATCH RFC bpf-next v2 1/4] bpf: Introduce BPF_HELPER_CALL
From:   Stanislav Fomichev <sdf@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/16, Alexei Starovoitov wrote:
> On Wed, Feb 15, 2023 at 3:59 PM Ilya Leoshkevich <iii@linux.ibm.com>  
> wrote:
> >
> > Make the code more readable by introducing a symbolic constant
> > instead of using 0.
> >
> > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  include/uapi/linux/bpf.h       |  4 ++++
> >  kernel/bpf/disasm.c            |  2 +-
> >  kernel/bpf/verifier.c          | 12 +++++++-----
> >  tools/include/linux/filter.h   |  2 +-
> >  tools/include/uapi/linux/bpf.h |  4 ++++
> >  5 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 1503f61336b6..37f7588d5b2f 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1211,6 +1211,10 @@ enum bpf_link_type {
> >   */
> >  #define BPF_PSEUDO_FUNC                4
> >
> > +/* when bpf_call->src_reg == BPF_HELPER_CALL, bpf_call->imm == index  
> of a bpf
> > + * helper function (see ___BPF_FUNC_MAPPER below for a full list)
> > + */
> > +#define BPF_HELPER_CALL                0

> I don't like this "cleanup".
> The code reads fine as-is.

Even in the context of patch 4? There would be the following switch
without BPF_HELPER_CALL:

switch (insn->src_reg) {
case 0:
	...
	break;

case BPF_PSEUDO_CALL:
	...
	break;

case BPF_PSEUDO_KFUNC_CALL:
	...
	break;
}

That 'case 0' feels like it deserves a name. But up to you, I'm fine
either way.
