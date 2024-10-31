Return-Path: <bpf+bounces-43618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3CF9B718C
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 02:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F7BB20EDB
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 01:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A942347C7;
	Thu, 31 Oct 2024 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hawWaENe"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11022083
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337472; cv=none; b=UiDvWBx/ROZGDAnRgkBgTgs61kbtJHSv3OVyRiXxlaCuOdJz8InoSKCLMWTPI4NiTbI56pQ1gDrgjfiVdOC7QFalWlgwIY/GbQnhGX+6Ea86y2QgGvgdDdUlkijteXbuEijOFehmmJSOzsErZyuzVxCPOvw4eP4rqnLdJVycfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337472; c=relaxed/simple;
	bh=xaaDaF/m7vHxyN8IGGUdxhbDxH9D+uwHM+N6bJ61w0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKcKOrbgk0h2iU5L4auROk12sf9FCoPuqEuT+JO4az8IZpOl08ngrPhV35yJY4lZh6AsKrybl7Wnuxo2WQthh4FmcEWTa/YmtR2fBs1s81vQ6Ul1XI4Np39BkoymBOIS88XUOb5v5ZFT3kS8+UrRn5+Fz9aHiCV5SmIhpTpu5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hawWaENe; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e56f78a9-cbda-4b80-8b55-c16b36e4efb1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730337467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBy8Ng1n+ziBeL2KTfh1+oSsW7siKHO3HDf2bItEBNc=;
	b=hawWaENe36fC7kbQTHjlL71Xtc20RWK0S25WZPgnWWVxEgp0CgrX5hNPgkaZwvtG9lc9YP
	PaeAOxGvmItJCgQaSn/Tgfz3WjM3qOs1VD9sC7OpGKxoovgiwfC947vlLMbdik+ZtpFVY1
	8KWxphGh5ILGpvg43rdsAJeoW/yPGTo=
Date: Wed, 30 Oct 2024 18:17:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com>
 <8fd16b77-b8e8-492c-ab69-8192cafa9fc7@linux.dev>
 <CAL+tcoBNiZQr=yk_fb9eoKX1_Nr4LuDaa1kkLGbdnc=8JNKnNg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoBNiZQr=yk_fb9eoKX1_Nr4LuDaa1kkLGbdnc=8JNKnNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/29/24 11:50 PM, Jason Xing wrote:
> On Wed, Oct 30, 2024 at 1:42 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 10/28/24 4:05 AM, Jason Xing wrote:
>>> +/* Used to track the tskey for bpf extension
>>> + *
>>> + * @sk_tskey: bpf extension can use it only when no application uses.
>>> + *            Application can use it directly regardless of bpf extension.
>>> + *
>>> + * There are three strategies:
>>> + * 1) If we've already set through setsockopt() and here we're going to set
>>> + *    OPT_ID for bpf use, we will not re-initialize the @sk_tskey and will
>>> + *    keep the record of delta between the current "key" and previous key.
>>> + * 2) If we've already set through bpf_setsockopt() and here we're going to
>>> + *    set for application use, we will record the delta first and then
>>> + *    override/initialize the @sk_tskey.
>>> + * 3) other cases, which means only either of them takes effect, so initialize
>>> + *    everything simplely.
>>> + */
>>> +static long int sock_calculate_tskey_offset(struct sock *sk, int val, int bpf_type)
>>> +{
>>> +     u32 tskey;
>>> +
>>> +     if (sk_is_tcp(sk)) {
>>> +             if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
>>> +                     return -EINVAL;
>>> +
>>> +             if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
>>> +                     tskey = tcp_sk(sk)->write_seq;
>>> +             else
>>> +                     tskey = tcp_sk(sk)->snd_una;
>>> +     } else {
>>> +             tskey = 0;
>>> +     }
>>> +
>>> +     if (bpf_type && (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
>>> +             sk->sk_tskey_bpf_offset = tskey - atomic_read(&sk->sk_tskey);
>>> +             return 0;
>>> +     } else if (!bpf_type && (sk->sk_tsflags_bpf & SOF_TIMESTAMPING_OPT_ID)) {
>>> +             sk->sk_tskey_bpf_offset = atomic_read(&sk->sk_tskey) - tskey;
>>> +     } else {
>>> +             sk->sk_tskey_bpf_offset = 0;
>>> +     }
>>> +
>>> +     return tskey;
>>> +}
>>
>> Before diving into this route, the bpf prog can peek into the tcp seq no in the
>> skb. It can also look at the sk->sk_tskey for UDP socket. Can you explain why
>> those are not enough information for the bpf prog?
> 
> Well, it does make sense. It seems we don't need to implement tskey
> for this bpf feature...
> 
> Due to lack of enough knowledge of bpf, could you provide more hints
> that I can follow to write a bpf program to print more information
> from the skb? Like in the last patch of this series, in
> tools/testing/selftests/bpf/prog_tests/so_timestamping.c, do we have a
> feasible way to do that?

The bpf-prog@sendmsg() will be run to capture a timestamp for sendmsg().
When running the bpf-prog@sendmsg(), the skb can be set to the "struct 
bpf_sock_ops_kern sock_ops;" which is passed to the sockops prog. Take a look at 
bpf_skops_write_hdr_opt().

bpf prog cannot directly access the skops->skb now. It is because the sockops 
prog sees the uapi "struct bpf_sock_ops" instead of "struct 
bpf_sock_ops(_kern)". The conversion is done in sock_ops_convert_ctx_access. It 
is an old way before BTF. I don't want to extend the uapi "struct bpf_sock_ops".

Instead, use bpf_cast_to_kern_ctx((struct bpf_sock_ops *)skops_ctx) to get a 
trusted "struct bpf_sock_ops(_kern) *skops" pointer. Then it can access the 
skops->skb. afaik, the tcb->seq should be available already during sendmsg. it 
should be able to get it from TCP_SKB_CB(skb)->seq with the bpf_core_cast. Take 
a look at the existing examples of bpf_core_cast.

The same goes for the skb->data. It can use the bpf_dynptr_from_skb(). It is not 
available to skops program now but should be easy to expose.

The bpf prog wants to calculate the delay between [sendmsg, SCHED], [SCHED, 
SND], [SND, ACK]. It is why (at least in my mental model) a key is needed to 
co-relate the sendmsg, SCHED, SND, and ACK timestamp. The tcp seqno could be 
served as that key.

All that said, while looking at tcp_tx_timestamp() again, there is always 
"shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;". shinfo->tskey can be 
used directly as-is by the bpf prog. I think now I am missing why the bpf prog 
needs the sk_tskey in the sk?

In the bpf prog, when the SCHED/SND/ACK timestamp comes back, it has to find the 
earlier sendmsg timestamp. One option is to store the earlier sendmsg timestamp 
at the bpf map key-ed by seqno or the shinfo's tskey. Storing in a bpf map 
key-ed by seqno/tskey is probably what the selftest should do. In the future, we 
can consider allowing the rbtree in the bpf sk local storage for searching 
seqno. There is shinfo's hwtstamp that can be used also if there is a need.

