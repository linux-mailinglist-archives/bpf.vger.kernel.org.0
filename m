Return-Path: <bpf+bounces-1099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F264170DFD2
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 17:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5F52812EA
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92C1F92E;
	Tue, 23 May 2023 15:00:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AD1E524
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 15:00:52 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B9411A;
	Tue, 23 May 2023 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8PeugkYtHQ0nMIBn48nsUlBDK7PMlRi6cAWFzaT+HTE=; b=FYXvaYk58FQZ4AbATcPnnzEr9i
	fZ4S8jkvXZ5Sg6qJhGWVtk0yWLxy5otN+6uwQwVTqKMOFDO/iOV01F0iUljVpeClnw4P9JY5pjy6n
	MUUFuDqYVxIx4hfoMzPJWBBrMx6XKP6P2DusmXSzu2Ejj54ERUU/3jlR0ENi0LoKvc2JRrr0J66Hr
	RA7q0F+0jdO/cE/jiIMO+VKJnjv5ybe+aEzyyhHc9kbH1uuh9z1gHBaAU/XU1wbRwj2xggI52MzNr
	/zllegpFzPMWwjOe5iaXa+JzsVVsr/u8HKzLyo59P083o0ZtxJ2JnE1V+o4WSVCC4dApW9vW/OOqQ
	CXQEXqRw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q1TVJ-000LWq-4S; Tue, 23 May 2023 17:00:48 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q1TVI-000Evj-JX; Tue, 23 May 2023 17:00:48 +0200
Subject: Re: [PATCH v3 bpf-next 1/4] bpf: validate BPF object in BPF_OBJ_PIN
 before calling LSM
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@kernel.org
Cc: cyphar@cyphar.com, brauner@kernel.org, lennart@poettering.net,
 linux-fsdevel@vger.kernel.org
References: <20230522232917.2454595-1-andrii@kernel.org>
 <20230522232917.2454595-2-andrii@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <342f13a8-e973-cc60-b63d-defb195cb0f1@iogearbox.net>
Date: Tue, 23 May 2023 17:00:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230522232917.2454595-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26916/Tue May 23 09:22:39 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/23/23 1:29 AM, Andrii Nakryiko wrote:
> Do a sanity check whether provided file-to-be-pinned is actually a BPF
> object (prog, map, btf) before calling security_path_mknod LSM hook. If
> it's not, LSM hook doesn't have to be triggered, as the operation has no
> chance of succeeding anyways.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

(I took this one already in, thanks!)

