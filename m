Return-Path: <bpf+bounces-141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACCA6F89E4
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938111C219D7
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 19:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37AAD2E1;
	Fri,  5 May 2023 19:55:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC17C12D
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 19:55:13 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F826A4
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 12:55:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643ac91c51fso570229b3a.1
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683316511; x=1685908511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnTAKnYqxnmy7lNKYOCP4yQWMDQeCQlQLzoOQ+NwcJA=;
        b=bvRT9wgYg/Lz4je/unhsUII02k/xPFNEyV7sw9RtmpZqDv45iRhoXuAwBXU0k79BYh
         f2Fwx0Ynu7xS2GZzWRuwNdaQLLob+N1n0qVV9sPT3u3swsBRB2kdc+JTF/91G+vOXVEY
         9ZtZ4LYrCUxxOcK5sMQdLPzujQpqQYOfs091SU9PP7YQgDDt+Y2I5w9E61NeZyMARd6+
         lD/uxf67x3hU4KJdWARUJs03bF/u5iqifGv6irftG2eY7TW7HrPL7FV9sg2ceuhMw5p+
         Qk44d32zTps+So+LwAV+rZ9+61Zp6EmPuNn554yvihJacbK79paoDO/jgoRSsUGCOAvp
         3S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683316511; x=1685908511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnTAKnYqxnmy7lNKYOCP4yQWMDQeCQlQLzoOQ+NwcJA=;
        b=fNUavLau37KlYkfCInALhPHWEIrNGoJn2a1nfR8NonK3+Ejf47in0/fYk/HY5nO4AM
         EQhM9sbbVEXvKwuyXjt5ZgCmNI5udRHOTOU2345BjMSGPRCf5/Ekah6PVvXsJTYmiqIM
         NoUlsiBZSflAI+ukVuZu4SafKn6pwi/h36oS20Q3yvnhoZqDRtKkh4Htava1PklzEn4+
         dAf2uxl7T30ocGPuKzAETE7A5Eiw1Aijlgh2oJDrWDfCMnfDwhwfiHNgTg3j00FX8c76
         3s91zarBpo/9dBYw4h/sqEDvnaoZL2hpdCUv+I9IqzKT+oTh3UsSBRPTi0wHxXp5+/hJ
         ts8Q==
X-Gm-Message-State: AC+VfDyeGRdNQb9pH2UWbky0NLxOBrxDvLtrbT4RmzEtjUw9i7DxqIwm
	mh7sNXY2xpaLoN66tNl8Uec=
X-Google-Smtp-Source: ACHHUZ55GzKdtXvnmGdJi631OhLerIoLFv0XR/qHjgAKzvobPh0fFO7bZgobk1eAmmeqlNStsvm4vg==
X-Received: by 2002:aa7:888c:0:b0:63b:859f:f094 with SMTP id z12-20020aa7888c000000b0063b859ff094mr3580632pfe.20.1683316510602;
        Fri, 05 May 2023 12:55:10 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:cce7])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78510000000b005a8de0f4c64sm1982714pfn.82.2023.05.05.12.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:55:10 -0700 (PDT)
Date: Fri, 5 May 2023 12:55:07 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 10/10] bpf: consistenly use program's recorded
 capabilities in BPF verifier
Message-ID: <20230505195507.gr4yzwco3kz5iyye@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230502230619.2592406-1-andrii@kernel.org>
 <20230502230619.2592406-11-andrii@kernel.org>
 <20230504222033.gw64tn73fverqccf@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CAEf4BzbuUvJ6zLvJJpMRc6jkx0GqbWdPFKi2GJ7G1WsjXpeUog@mail.gmail.com>
 <CAEf4BzYa0A3d8rp7KqCsuhOFicW7McNcv2Oz3J3ceZ0g2LROyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYa0A3d8rp7KqCsuhOFicW7McNcv2Oz3J3ceZ0g2LROyw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 05, 2023 at 12:08:21PM -0700, Andrii Nakryiko wrote:
> On Thu, May 4, 2023 at 3:51 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, May 4, 2023 at 3:20 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, May 02, 2023 at 04:06:19PM -0700, Andrii Nakryiko wrote:
> > > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > > index 4d057d39c286..c0d60da7e0e0 100644
> > > > --- a/kernel/bpf/core.c
> > > > +++ b/kernel/bpf/core.c
> > > > @@ -661,7 +661,7 @@ static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
> > > >  void bpf_prog_kallsyms_add(struct bpf_prog *fp)
> > > >  {
> > > >       if (!bpf_prog_kallsyms_candidate(fp) ||
> > > > -         !bpf_capable())
> > > > +         !fp->aux->bpf_capable)
> > > >               return;
> > >
> > > Looking at this bit made me worry about classic bpf.
> > > bpf_prog_alloc_no_stats() zeros all fields include aux->bpf_capable.
> > > And loading of classic progs doesn't go through bpf_check().
> > > So fp->aux->bpf_capable will stay 'false' even when root loads cBPF.
> > > It doesn't matter here, since bpf_prog_kallsyms_candidate() will return false
> > > for cBPF.
> > >
> > > Maybe we should init aux->bpf_capable in bpf_prog_alloc_no_stats()
> > > to stay consistent between cBPF and eBPF ?
> 
> I'd like to avoid doing this deep inside bpf_prog_alloc_no_stats() or
> bpf_prog_alloc() because this decision about privileges will be later
> based on some other factors besides CAP_BPF. So hard-coding
> bpf_capable() here defeats the purpose.
> 
> I did look at classic BPF, there are three places in net/core/filter.c
> where we allocated struct bpf_prog from  struct sock_fprog/struct
> sock_fprog_kern: bpf_prog_create, bpf_prog_create_from_user,
> __get_filter.
> 
> Would it be ok if I just hard-coded `prog->aux->bpf_capable =
> bpf_capable();` (and same for perfmon) in those three functions? Or
> leave them always false? Because taking a step back a bit, do we want
> to allow privileged classic BPF programs at all? Maybe it's actually
> good that we force those cBPF programs to be unprivileged?

Indeed. cBPF is always allowed for unpriv.
In that sense the value prog->aux->bpf_capable for cBPF is meaningless.
Let's keep the patch as-is then.

