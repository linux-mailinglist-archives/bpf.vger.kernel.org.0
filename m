Return-Path: <bpf+bounces-13045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555217D3DCF
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 19:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A90B20C6F
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 17:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B9210F5;
	Mon, 23 Oct 2023 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIsp1HOl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBB210E4
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:33:24 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B9A90
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:33:22 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b79f96718eso2333732a12.0
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698082402; x=1698687202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYNuecxtzZjpZH/6MqhOuU1Zd2Qk8RtvUHnT7LYxHjo=;
        b=KIsp1HOlV5Yl9XQnr3bAMFQsw/NTCnd0LtacWED0L6mSY6IdgOJhH3lwi0eKam7SEY
         usJtQPDCouKGctYUVT/OZtYOW6oujk4MuPyg93y1oy++MHaivewn1pxqsxPkvapXRxuj
         91fiBLSBlIEjEocPbFbOl6LbQRVJzrTaz5M2vcz7pcC1yYSk/q9Or9h1MdQ/s8RiqpZs
         ecOT0ZktY4kebvO1HRabywWZs+PuNCdVcV5km1sNUTC/UjbQFHCIhgWPyOlx1DGbVmD8
         Y4xwE1uVpjSi1Zjg/EQeWP9yv0ORMFUi2KmCP2vGN2WCakG/nDK1L5nsDWPq+W44TQ6d
         O65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082402; x=1698687202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYNuecxtzZjpZH/6MqhOuU1Zd2Qk8RtvUHnT7LYxHjo=;
        b=mOGboUitMkk5biNHFnSRVT2P10pLm1sjaiHo1Jc/Maf5Ts7YTHWmP6EVH9QPPbYzhG
         SjMPI2NbQThLcCW7AqH8iV0jw7yKxDXKDXJydq92+B8DIZQ6v0k0nzWQ/q7y/3KUzvrH
         /VDbf+96oUsK7E3lkmXosXO/JhrPKjvvVO6eRkFh8Myx6MYFu/sOcsH1eJgB2JQt1qQx
         sgYxOxhS+VV1k+oYyES/ihA3pHKFes7eb0O+wTP7QcuKJJDKbet4GTfNmgyWndJV5iY/
         crr5ugwK8QP53/7RhYYIhaOHkr76AHFMO+rYO+5BgDyIeOkKNAsq3sB6c19a/dvyZyLF
         PuGQ==
X-Gm-Message-State: AOJu0YwVxpzlQmf+sfNiBlu9nU/XNu/viJemj1QcrrdKN+3DRbZ0m7tG
	t3oNyUp+ovVT6Zv94BOdgHkepyc=
X-Google-Smtp-Source: AGHT+IG6fqVFdLE05i/CSXQXSSNf9aMPT9Hh+K6djI2RTsJP0k9WZS7ESjKpKYRZVUocDWtqyyvYfy0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:e28e:b0:27d:2649:84b0 with SMTP id
 d14-20020a17090ae28e00b0027d264984b0mr348023pjz.3.1698082402373; Mon, 23 Oct
 2023 10:33:22 -0700 (PDT)
Date: Mon, 23 Oct 2023 10:33:20 -0700
In-Reply-To: <20231020181218.05ea35af@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com> <20231019174944.3376335-2-sdf@google.com>
 <20231020181218.05ea35af@kernel.org>
Message-ID: <ZTauYK21mT_Djn7t@google.com>
Subject: Re: [PATCH bpf-next v4 01/11] xsk: Support tx_metadata_len
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"

On 10/20, Jakub Kicinski wrote:
> On Thu, 19 Oct 2023 10:49:34 -0700 Stanislav Fomichev wrote:
> > - 4-byte aligned
> 
> But there is an 8B field in it. Won't this trap on some funky
> architecture of yore?

Hmm, good point, will update this to 8 byte alignment and will use
8-bit timestamp as a reason.

