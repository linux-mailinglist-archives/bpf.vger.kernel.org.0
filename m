Return-Path: <bpf+bounces-5798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C417609BB
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 07:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DDF1C20D90
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 05:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858848C08;
	Tue, 25 Jul 2023 05:49:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5928BE5
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 05:49:18 +0000 (UTC)
X-Greylist: delayed 446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 22:49:16 PDT
Received: from out-63.mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5839B6
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 22:49:16 -0700 (PDT)
Message-ID: <f93c110f-33d4-6991-0708-1602afe5a7d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690263706; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9iw6D2Emyp2lJwPspPM34X+HGJqZ6D4YOHn1dUUa3Q=;
	b=q++KtbCSx740QBKosRxtlUuYgAS7m46IZAuwLpC8zFAzyCOJr4fuc0UM3DjLaGZwx/VLV0
	KvlH2yDyL/fZSDaaAR3DMnWGrlGcL7YowISNTktPLIP7C8OvRriEiQh93SWI9qt6KDCPfu
	0UypHItmx35E5C83VWSF45W2cS9bu0Q=
Date: Mon, 24 Jul 2023 22:41:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v2] MAINTAINERS: Replace my email address
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yhs@fb.com>
References: <20230725044348.648808-1-yonghong.song@linux.dev>
 <CAADnVQLrH4V6UxBcT9QSbrS7Zi0EhnG-fpFZStu1QuWoz7oUhA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLrH4V6UxBcT9QSbrS7Zi0EhnG-fpFZStu1QuWoz7oUhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/24/23 9:51 PM, Alexei Starovoitov wrote:
> On Mon, Jul 24, 2023 at 9:44 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> From: Yonghong Song <yhs@fb.com>
>>
>> Switch from corporate email address to linux.dev address.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Changelog:
>>    v1 -> v2:
>>     - Use new address as the Signed-off-by address.
> 
>  From and SOB should match otherwise various scripts will complain.

Thanks! Just fixed in v3.


