Return-Path: <bpf+bounces-2989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F67737DBD
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 10:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F4281436
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 08:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A709C8C1;
	Wed, 21 Jun 2023 08:44:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC95C97
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 08:44:11 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C9A1985;
	Wed, 21 Jun 2023 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YGAjFCPPEDmRlHxNKozvmFJN8CRVKmi74gig/bzaVnI=; b=LiDb+DkjazX6QuMd6qNXUjrM0M
	NK/IYXnN5GNENo3hHKhXxhQgKy89SLho0Abds00xLded015Dg5idJ12Mlcm8DmF+R3whIUBpCQ7z4
	oKsa0PY1cnjbbP1JnB7Ju33dclISf59zA/W4hDcJXjS6UiB3hiNiDD9zsUClxu7RdfW4j3svKLJi5
	S3BPqjkEVYrz7O/1Sx4V+Lts76xkHHu93YohE5cV6PQUXf8Fd/YrCTk3orAi9mGXrHmUPRElcIpGT
	YeapTVwp2pyBJ/D+/eN7KBOLsMoOPkBL/4uYiNzQePLBGatgciiEBzbkuyYZWhj8WM05/aaXJZ28x
	fCP0MWrA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qBtRV-0002Ke-0N; Wed, 21 Jun 2023 10:43:57 +0200
Received: from [178.197.248.44] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qBtRU-000N9r-8i; Wed, 21 Jun 2023 10:43:56 +0200
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
To: Yonghong Song <yhs@meta.com>, Nick Desaulniers <ndesaulniers@google.com>
Cc: Florent Revest <revest@chromium.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, martin.lau@linux.dev,
 ast@kernel.org, andrii@kernel.org, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, nathan@kernel.org, trix@redhat.com,
 stable@vger.kernel.org
References: <20230615145607.3469985-1-revest@chromium.org>
 <CAEf4BzbjCt3tKJ40tg12rMjCLXrm7UoGuOdC62vGnpTTt8-buw@mail.gmail.com>
 <CABRcYmK=yXDumZj3tdW7341+sSV1zmZw1UpQkfSF6RFgnBQjew@mail.gmail.com>
 <c26de68d-4a56-03a0-2625-25c7e2997d45@meta.com>
 <CAKwvOdnehNwrDNV5LvBBwM=jqPJvL7vB9HwF0YU-X5=zbByrmg@mail.gmail.com>
 <6b63301f-96b2-74b9-c156-3a34fb5ad346@meta.com>
 <CAKwvOdna=1Sg4Aab=BE6F86H9ZE7kPRM=VTkqQuGiF-Jdze-cA@mail.gmail.com>
 <2dcc697a-46fe-0933-0508-90ebad9ac8f3@meta.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b0084c8b-fe32-f1db-ad01-961265ce00fb@iogearbox.net>
Date: Wed, 21 Jun 2023 10:43:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2dcc697a-46fe-0933-0508-90ebad9ac8f3@meta.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26945/Tue Jun 20 09:30:24 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/21/23 5:28 AM, Yonghong Song wrote:
> On 6/20/23 8:07 AM, Nick Desaulniers wrote:
[...]
>> No, all kernels have this issue, when using `LLVM=1 LLVM_IAS=0`.  It's
>> more likely that someone is using that combination for branches of
>> stable that predate 4.19 (such as 4.14) but we do still try to support
>> that combination somewhat, even if we recommend just using `LLVM=1`.
>> Interop between toolchains is still important, even if "why would you
>> do that?"
> 
> Okay, yes, although 'LLVM=1' is recommended way to compiler clang
> based kernel, users can certainly do 'LLVM=1 LLVM_IAS=0' as well
> although not recommended. Then it is okay to put a bug fix in
> the commit message. Just need to clarify that
>    - > 5.10 kernel, LLVM=1 (LLVM_IAS=0 is not the default)
>      is recommended but user can still have LLVM=1 LLVM_IAS=0
>      to trigger the issue
>    - <= 5.10 kernel, LLVM=1 (LLVM_IAS=0 is the default) is
>      recommended in which case gnu as will be used.

Given this was already applied to bpf few days ago, I've just updated the
commit message to reflect the above. Agree that this is valuable info to
retain for the log.

Thanks everyone,
Daniel

