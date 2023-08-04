Return-Path: <bpf+bounces-6946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF4876F971
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 07:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2911C20934
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 05:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091884400;
	Fri,  4 Aug 2023 05:13:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859D1FC8
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 05:13:11 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7B819B0
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 22:13:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so26452631fa.2
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 22:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691125988; x=1691730788;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ALnEdPrrx/K+39dK5AYBF58uSeLYCTSkAv6zbraQiBE=;
        b=OSG4PQGY7jg4daVGPaRd8bhUaD3gKjlyQo9Ch/uumcaylyGIKH++6dC0xpk5rpUcvn
         7YWP4obReWJLLLFkNxU19pOE06Sp+RN0ZfLN+Te/EpXKI2IPWG7+2AsPkVZ3qJBtC+0B
         lGbszCX6kZjyJdL/njnj5+zvqYwU8HbQUUCYv+rXPDQ8RDRx4yoqBJmz3I1FqpudiIYM
         TDH1n2Im8cNC1IqJroNuHlv/hJvIVfixcVqJ4pBgkTLw/v9aMDNnNogtYQxKn2HOZ71p
         TkI9SDMBsSBHU/0pyVAoDU0LE1OXKqcXtVi7rtUL1L1w6FsLhuACYDOcDqD2ocIXOEu6
         3SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691125988; x=1691730788;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALnEdPrrx/K+39dK5AYBF58uSeLYCTSkAv6zbraQiBE=;
        b=Y6NXtNKC6wn9CYz+lsQvuivolUZSYpiGVl2JGar8ixTPJ7K4YrthgD/yMxUucp0YRE
         uKGA8YkC9TnDLkBwAJf6wqf9/ZryQO1bHds7UN70vF5CVjwGUEqeYF/2xq3kYDedJ0CR
         dbPMu8pRJi8MenC4g9NKP408ft0oY6hvKKJOJQr6By/s05X7DWkfYBsOqQyHWA2Oq8iS
         EpprSoVGM+9yVEXiR/L3pkXIl1mG2QkIlboudIPmIZcM9RTAFSsseZZjK5sBAOQubgKe
         tw3RB5pBYxPyPFOrI4/VESRDrpvAxXQL88poVoO+0uciA0meJios1lNV499dHUAwJVHe
         ZUaQ==
X-Gm-Message-State: AOJu0YzwwjmN+iMSlHLCLyPNOTO/FwjPKf2Ohuihq7jay5FxnJDgGuGV
	GBUTz9Yor+ooLbw4+60TM60cbA==
X-Google-Smtp-Source: AGHT+IFsoDMpG6Dz/YGILx1IpXxmKeRThqsGMvqUOxwll2af+onie75bYoWyn48KE5kwEv1XXtyLTA==
X-Received: by 2002:a2e:95d7:0:b0:2b9:ea17:5590 with SMTP id y23-20020a2e95d7000000b002b9ea175590mr582690ljh.16.1691125987960;
        Thu, 03 Aug 2023 22:13:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003fe18d03188sm1405307wmj.17.2023.08.03.22.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 22:13:07 -0700 (PDT)
Date: Fri, 4 Aug 2023 08:13:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org
Subject: Re: [bug report] selftests/bpf: Verify that the cgroup_skb filters
 receive expected packets.
Message-ID: <d52eeb7b-55b3-4696-83bc-4d64f2853dfe@kadam.mountain>
References: <cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain>
 <8820810d-572f-1e63-0b58-a496fe49b4f1@gmail.com>
 <eb2997ef-0fd4-a564-d166-9459b017e10c@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb2997ef-0fd4-a564-d166-9459b017e10c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 01:43:33PM -0700, Kui-Feng Lee wrote:
> > >      113         int err;
> > >      114
> > >      115         addr.sin6_port = htons(get_sock_port_v6(listen_fd));
> > > --> 116         if (addr.sin6_port < 0)
> > >                      ^^^^^^^^^^^^^^^^^^
> > > Impossible and also it doesn't make sense to compare network endian data
> > > with < 0.
> > 
> > Hi Dan,
> > 
> > Thank you for pointing it out. It should check the returned value
> > of get_sock_port_v6() before calling htons(). I will send a patch
> > to fix it asap.
> 
> Could you show me how to run Smatch againt bpf selftests?
> 

Oh wow...  You don't want to know.  So sometimes I'll go through and
do a `find -name \*.c` and if there isn't a matching .o file I'll just
run:

	~/path/to/smatch tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c

Smatch has a thing where if the .h file is missing it will just include
the nearest .h file with a similar name.  This doesn't work well and
generates a ton of errors.  But I grep the output for specific types
of errors like "is never less than zero".

regards,
dan carpenter


