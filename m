Return-Path: <bpf+bounces-9083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895D178F086
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 17:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A152C1C20A35
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9B713FE9;
	Thu, 31 Aug 2023 15:43:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9BA9470;
	Thu, 31 Aug 2023 15:43:15 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76AA1A3;
	Thu, 31 Aug 2023 08:43:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-500913779f5so1874739e87.2;
        Thu, 31 Aug 2023 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693496593; x=1694101393; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wWU7ARl/VeWoDwb41tKr97MFSWO0cUVuC1TH0NtzKzs=;
        b=Shi0myw/R+MLuwOLbyr+y3aLk06oRe0iVr8s/IK3xaO/r8uMzk0ZY5817pmcStGjno
         DIfNy2hdVf/3vj0FzsFzV7AU6DiWWW1FgNd1WoIDNrV0ubri9Ycg6WXAsAQhwUPhOkAq
         Yuty/k16ufHugZ8PKx1Vec18QrlGNrLrv6Jxp2TIsEKsdWw//J33OTEKYBhCNuCJIPFC
         2B66yKyZ2VO+ERqIRUZkICiP+lvUOqAzO+Gn6Q41tkkxi04OCTvOPG/KY6PgCwlnrHdX
         /TE+WiHgIWY4ajLrtihCtoQGkNzhTyREfzqQmkSE2PlavfnQIacKQnlnfqfuGdu/PPzk
         O3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693496593; x=1694101393;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWU7ARl/VeWoDwb41tKr97MFSWO0cUVuC1TH0NtzKzs=;
        b=Y0q62T11UhbmvqiFaplB2WW+0rRX3g0MjMjZriDwJ2duX03jZy7Wn8VEuKFQToxj2C
         UqAZG/fwduFYesH/TjcTZxsJdC7UYugXdmmcGIz16rpdbLn+tpXvqnnNhKlrb3hABIg8
         k2DABmLvDzbVPy41W3ZSe3QPnaQpz2E0m18ruqLdMJXF1LfUBlDZffwIEKyOLWnDG169
         C49JZ2IORz41YCDbS1QkwfImSGSKL54sL7P3unfsoRr5QqLkhJvD0u16+e+4kvDiATEW
         oE81UDyb8U+QD1CA4i196qRRVcKCelKpB0CZGrXdCK1lp9HXcIuS0k/oVtpPRnuldv60
         WAig==
X-Gm-Message-State: AOJu0Yz5mZqbm1ejm5PQXWrDNouHQS0LLtIVean7Fcsci5cw4Ri1CY7m
	9ZTMxkwdhmkr+AyJxEApazc=
X-Google-Smtp-Source: AGHT+IFd8P0m9InxFqPIUpwg/UOlWtA9dYXaJ3wysR/4dDUWzgwX45u/SQnlCJG6rplZ9zHFcDdRYQ==
X-Received: by 2002:a19:3814:0:b0:500:a408:dbd with SMTP id f20-20020a193814000000b00500a4080dbdmr4153742lfa.55.1693496592679;
        Thu, 31 Aug 2023 08:43:12 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f5-20020a50ee85000000b0052595b17fd4sm904061edr.26.2023.08.31.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:43:12 -0700 (PDT)
Message-ID: <37423e512767dd10f4ac427923d0c6a38a9f2474.camel@gmail.com>
Subject: Re: [BUG bpf-next] bpf/net: Hitting gpf when running selftests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huawei.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Martin KaFai Lau
 <kafai@fb.com>,  Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Hou Tao <houtao1@huawei.com>
Date: Thu, 31 Aug 2023 18:43:10 +0300
In-Reply-To: <818ce7b6-96ca-2644-de41-2c05de13a77c@huawei.com>
References: <ZO+RQwJhPhYcNGAi@krava> <ZO+vetPCpOOCGitL@krava>
	 <de816b89073544deb2ce34c4b242d583a6d4660f.camel@gmail.com>
	 <082a6db6838d3aee5ca39eabd35d4da0c9691a0d.camel@gmail.com>
	 <818ce7b6-96ca-2644-de41-2c05de13a77c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-31 at 23:34 +0800, Xu Kuohai wrote:
> On 8/31/2023 11:03 PM, Eduard Zingerman wrote:
> > On Thu, 2023-08-31 at 13:52 +0300, Eduard Zingerman wrote:
> > > On Wed, 2023-08-30 at 23:07 +0200, Jiri Olsa wrote:
> > > > On Wed, Aug 30, 2023 at 08:58:11PM +0200, Jiri Olsa wrote:
> > > > > hi,
> > > > > I'm hitting crash below on bpf-next/master when running selftests=
,
> > > > > full log and config attached
> > > >=20
> > > > it seems to be 'test_progs -t sockmap_listen' triggering that
> > >=20
> > > Hi,
> > >=20
> > > I hit it as well, use the following command to reproduce:
> > >=20
> > >    for i in $(seq 1 100); do \
> > >      ./test_progs -a 'sockmap_listen/sockmap VSOCK test_vsock_redir' =
\
> > >      | grep Summary; \
> > >    done
> > >=20
> >=20
> > For what its worth, bisect points to the following commit:
> > 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
> >=20
> > Which was merged into bpf-next 3 days ago as a part of:
> > 3ca9a836ff53 ("Merge tag 'sched-core-2023-08-28' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/tip/tip")
> >=20
> > Scheduling changes uncovered some old race condition?
> >=20
>=20
> As replied in another mail, I think the issue is introduced by this commi=
t:
>=20
> 405df89dd52c ("bpf, sockmap: Improved check for empty queue")

Sorry, missed sibling sub-thread.



