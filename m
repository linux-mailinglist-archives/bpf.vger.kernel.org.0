Return-Path: <bpf+bounces-2616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E6073126A
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 10:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9956F281691
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 08:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E783D68;
	Thu, 15 Jun 2023 08:39:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFBD137A
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 08:39:24 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930FB272E;
	Thu, 15 Jun 2023 01:39:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b203891b2cso23205821fa.3;
        Thu, 15 Jun 2023 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686818361; x=1689410361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYPoBgKpff/N5vL2NYQromt5SJIv0kpE1F1g2CtiMe4=;
        b=K0mZGj+B9ju6bB+0Qnh6eiSvjANCsLZ0CLFLBr3swByr1+Tc0JtsD+9bHaqzQpR8oj
         h8fmUwy5bYXCo21mG2erVHK7RZ2v+iQ5YWF78S7MxPOUrQsjHhOeajT8I4xKy9nERPm4
         bfOAFczKEZNW9Ok3+Ph9wKztaxQfDmFccaIgn3GqbEf0tdcD4hzMEn4v65MwBQdlJEiB
         fSjAS1kE3KLquHrPude4U23PurDLZdnJRe82eWaCZgkRNXSLZzt6x09LiT1HVMgFTkPN
         r2jyD/p2Z+FkDc53LBig+w74l3VC9JXOvj+8Lgm7zlHNwvs7wJg7znHqveKgWfC1K5UO
         WTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818361; x=1689410361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYPoBgKpff/N5vL2NYQromt5SJIv0kpE1F1g2CtiMe4=;
        b=iZ+ui+X4T3UgPTbH0j/TmWNgD4P+t4IcOfID8dVdL8kvZUO2I5O13Q252q8SeUgRMr
         mmbhi8IjO6LjrjNzlq4hF7kvn5nXv+1AIzO8/9T3IhBQuCNgju3uGGbwhX497okn0dsx
         EctQEfHB1P/UbJmrID9gu6Iz5jCRZbcighUFvoI8AmPiGIznx32E+GkG4vSijcPTnThK
         cflWGtHuBtvR06vxrb1KAZOp+iRDHUiU1IMyqJAPJ20kYaONcNBPgaHT0lt1peM4xbR7
         kxH8rdCQep+Vau5CGsCZctaKIYTQqgTAsSjHE5vi5MIADm7mxnhcyMTnwNAQvCMii+vt
         hMFA==
X-Gm-Message-State: AC+VfDwirdgGueQBBSj+6Fd1dTRB54nX+c3ljKN7BNgl5wVzawW6fYMu
	WOTWcev6rMVLciKXqcChNJODPII3DBV4Mw==
X-Google-Smtp-Source: ACHHUZ5ZN0KtTs6SA22L/Cs2r6tPgcsC5B3hsEh0GmIwaUcffQD+gUbnbGV5gcL3/ktPD6mQz/D9Yw==
X-Received: by 2002:a2e:9b8f:0:b0:2ad:c1ec:fa3 with SMTP id z15-20020a2e9b8f000000b002adc1ec0fa3mr8863129lji.20.1686818360423;
        Thu, 15 Jun 2023 01:39:20 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm20394348wrv.108.2023.06.15.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 01:39:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 15 Jun 2023 10:39:18 +0200
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: ppc64le vmlinuz is huge when building with BTF
Message-ID: <ZIrONqGJeATpbg3Y@krava>
References: <ZIqGSJDaZObKjLnN@codewreck.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIqGSJDaZObKjLnN@codewreck.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 15, 2023 at 12:32:24PM +0900, Dominique Martinet wrote:
> Hi,
> 
> coming from alpine: https://gitlab.alpinelinux.org/alpine/aports/-/issues/12563

hi,
it's probably burried somewhere in that discussion, but do you have
kernel version (or commit) where that increase happened?

also link for used config would be great

thanks,
jirka

> 
> alice noticed the kernel packages got quite bigger, in particular for
> ppc64le I've confirmed that the vmlinuz file size jump when building
> with BTF:
> currently released package with BTF:
> https://dl-cdn.alpinelinux.org/alpine/edge/main/ppc64le/linux-lts-6.1.33-r0.apk
> 272M	boot/vmlinuz-lts
> 
> test build without BTF:
> https://gitlab.alpinelinux.org/martinetd/aports/-/jobs/1049335
> 44M	boot/vmlinuz-lts
> 
> 
> Is that a known issue?
> We'll probably just turn off BTF for the ppc64le build for now, but it
> might be worth checking.
> 
> 
> While I have your attention, even the x86_64 package grew much bigger
> than I thought it would, the installed modules directory go from 90MB to
> 108MB gzipped); it's a 18% increase (including kernel: 103->122MB) which
> is more than what I'd expect out of BTF.
> Most users don't care about BTF so it'd be great if they could be built
> and installed separately (debug package all over again..) or limiting
> the growth a bit more if possible.
> I haven't tried yet but at this point ikheaders is probably worth
> considering instead..
> Perhaps we're missing some stripping option or something?
> 
> 
> Thanks!
> -- 
> Dominique Martinet | Asmadeus
> 

