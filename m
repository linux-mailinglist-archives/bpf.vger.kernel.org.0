Return-Path: <bpf+bounces-12259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 678457CA739
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 13:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994751C204E8
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700F266AA;
	Mon, 16 Oct 2023 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NDZxOhu2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4615ADD;
	Mon, 16 Oct 2023 11:56:35 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7619BEB;
	Mon, 16 Oct 2023 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WRPI/vvAe1a/d/T53OXiNe5f7JTZlBNBUbkDycSd458=; b=NDZxOhu2bvM4P4YdZuYfpQ2lwo
	dhyoO/D1aKBPPjhCqUPDdtavMHg9e0J0xKrO2FOVJ3qtwef5GICHvfzMSARLIaRWxVQoZsXYoHd/w
	n2/mTj7GwkocyAJH1+TFnFZQUtGn9KavOtBbv2Fgu0fTIeoxcIbA2gT2O6rER665ZqrYZrZvmgtqi
	wBieyPcQuIQLnA6WKx9QgMb8RexRDBwgv0VR3EN+HVBDy6FmONTyQ4VJES9N1znpw92eGDq8KefaC
	R7lCW8CFqsJAOod3C1RumaGqWTLeh/kpUtV86/EOL6MpQv3LpG9/hJAtbA/nw0QSoC7cJWt0ageZQ
	syGDO2KA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsMCw-00093v-5q; Mon, 16 Oct 2023 13:56:26 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsMCv-0002uD-7t; Mon, 16 Oct 2023 13:56:25 +0200
Subject: Re: [PATCH bpf-next -v4] net: Add a warning if NAPI cb missed
 xdp_do_flush().
To: John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yonghong Song
 <yonghong.song@linux.dev>, =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?=
 <toke@redhat.com>
References: <20230929165825.RvwBYGP1@linutronix.de>
 <20231004070926.5b4ba04c@kernel.org> <20231006154933.mQgxQHHt@linutronix.de>
 <20231006123139.5203444e@kernel.org> <20231007154351.UvncuBMF@linutronix.de>
 <20231010065745.lJLYdf_X@linutronix.de>
 <652627b386bbe_2d55e208d6@john.notmuch>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5efb2093-537e-0f7d-beef-d32c02ec4a3d@iogearbox.net>
Date: Mon, 16 Oct 2023 13:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <652627b386bbe_2d55e208d6@john.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27063/Mon Oct 16 10:02:17 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Sebastian,

On 10/11/23 6:42 AM, John Fastabend wrote:
> Sebastian Andrzej Siewior wrote:
>> A few drivers were missing a xdp_do_flush() invocation after
>> XDP_REDIRECT.
>>
>> Add three helper functions each for one of the per-CPU lists. Return
>> true if the per-CPU list is non-empty and flush the list.
>> Add xdp_do_check_flushed() which invokes each helper functions and
>> creates a warning if one of the functions had a non-empty list.
>> Hide everything behind CONFIG_DEBUG_NET.
>>
>> Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> Acked-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> LGTM.
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Do you have a chance to send a v5 rebase? It does not apply to bpf-next.

Other than that, the patch lgtm.

Thanks,
Daniel

