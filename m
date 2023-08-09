Return-Path: <bpf+bounces-7374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AC27764AC
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2334281580
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF11C9E2;
	Wed,  9 Aug 2023 16:06:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90F1AA74
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:06:56 +0000 (UTC)
Received: from out-97.mta1.migadu.com (out-97.mta1.migadu.com [95.215.58.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7CA1BD9
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:06:54 -0700 (PDT)
Message-ID: <2ede575a-b79f-c1ed-cc48-b837ec9d6efc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691597212; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/HJd054E3OrwbF6H6P4qRBpvrksWTY5QYM8fQog5yE=;
	b=V4Gg5berU90owSEcmS1FeZKSZ5WZT5Cch+JekCelrumTzbZMt2i3UCFBJxGElN1f7bI6U5
	Y17LfK5j2hu7SHvHR7BbrZMv6MsYNeVzR1Kpn1tPsXs7PED/FfTXe+RfeGNiMve+2kSjc8
	LO8g0F5nP3aTlwDf2kOxR/5+/6TiPHg=
Date: Wed, 9 Aug 2023 09:06:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCHv7 bpf-next 01/28] bpf: Switch BPF_F_KPROBE_MULTI_RETURN
 macro to enum
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>
References: <20230809083440.3209381-1-jolsa@kernel.org>
 <20230809083440.3209381-2-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230809083440.3209381-2-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/9/23 1:34 AM, Jiri Olsa wrote:
> Switching BPF_F_KPROBE_MULTI_RETURN macro to anonymous enum,
> so it'd show up in vmlinux.h. There's not functional change
> compared to having this as macro.
> 
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

