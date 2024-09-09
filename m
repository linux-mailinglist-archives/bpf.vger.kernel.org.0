Return-Path: <bpf+bounces-39312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D800971921
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 14:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9DF286670
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997FF1B78E1;
	Mon,  9 Sep 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ltDLlhXf"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88361B375C
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884196; cv=none; b=HeGloEA3zzFVwruU9vZLQR+S1XKEg7O76rzYoG8v3wNekqAjgTmvsyPodP8M/Sz29Y0+32JFWUKlfFCQ3/ZglaVJkVB5ElZCfiNwl9QwRganhLeD4LFb4KvypjbVs782WzANTvIPdCXyBsv9kx2++3ZeCH+itMUwB++cGujwU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884196; c=relaxed/simple;
	bh=cOL5C0CEj+6nZ3F3zE9KRP2Wg/y6Y4f/HIvvxnUXu0s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=d4xtWnpaoFujNxI8edNWpA2zdD6+RrwhdgvF2Sxsx1gEq4hqg3iGBVmLQaaIsR3ngULt2SuB4Q3+ON7h5sDmaAqyY92maLWYDbJmB5TEjTVkBTbiO8qd/wfg6BLNgn1oRd7DS7fI347oCwhNwqt8ao8lqP8IR+2XiZVYTvYwHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ltDLlhXf; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kgvFIuLDce4hK0QNfKrLUHZfVIvskWHvzuLVj/RZnfY=; b=ltDLlhXfrO5sqkVZ9PNHnvW+oK
	2OSdM28X8BbxdDOCzgREnQHyd1DnfwuSD6mVYqviuapzO5dByAKwf5wkvm/0Lo+RUoOmuk7NfT/C4
	+p2p8M6OxNJyGzSrH/rQ+EgjLFtoPag8wW1JUHcr/J4vz/dQEFzQxZEkmYCwoGSws8KqBRTqOh6ct
	N+/pd4Z9qoGysUgRdWH71Jq6I151lJpIyKiUaq9oQo+Q2+rMju+3i25+FfWPqlVkHDu2EGuRjHQIP
	/HbgK6H75KmeY3zSB82+oXfMXAYxqoP8ijVsGEH2WqWrG8Pm7rqX4L9xqGEP44sg/UU9SO3GP6Y0I
	z7KhtmsQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sndJf-000Kn4-Ck; Mon, 09 Sep 2024 14:16:23 +0200
Received: from [178.197.249.12] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sndJe-000EpQ-1C;
	Mon, 09 Sep 2024 14:16:22 +0200
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Zero former ARG_PTR_TO_{LONG,INT}
 args in case of error
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 kongln9170@gmail.com
References: <20240906135608.26477-1-daniel@iogearbox.net>
 <20240906135608.26477-5-daniel@iogearbox.net>
 <CAADnVQ+GSCAPC7v787c4poFY4ku=L9q1cn1d=A3YhVRUomoVrQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fb38bb54-c59b-ba36-821f-f7dfcaa390cc@iogearbox.net>
Date: Mon, 9 Sep 2024 14:16:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+GSCAPC7v787c4poFY4ku=L9q1cn1d=A3YhVRUomoVrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27393/Mon Sep  9 10:29:16 2024)

On 9/7/24 12:35 AM, Alexei Starovoitov wrote:
> On Fri, Sep 6, 2024 at 6:56 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> -       if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
>> -               return -EINVAL;
>> -
>> -       if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))
>> +       if (unlikely((flags & ~(BPF_MTU_CHK_SEGS)) ||
>> +                    (flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))) {
>> +               *mtu_len = 0;
>>                  return -EINVAL;
>> +       }
>>
>>          dev = __dev_via_ifindex(dev, ifindex);
>> -       if (unlikely(!dev))
>> +       if (unlikely(!dev)) {
>> +               *mtu_len = 0;
>>                  return -ENODEV;
>> +       }
> 
> I don't understand this mtu_len clearing.
> 
> My earlier comment was that mtu is in&out argument.
> The program has to set it to something. It cannot be uninit.
> So zeroing it on error looks very odd.
> 
> In that sense the patch 3 looks wrong. Instead of:
> 
> @@ -6346,7 +6346,9 @@ static const struct bpf_func_proto
> bpf_skb_check_mtu_proto = {
>          .ret_type       = RET_INTEGER,
>          .arg1_type      = ARG_PTR_TO_CTX,
>          .arg2_type      = ARG_ANYTHING,
> -       .arg3_type      = ARG_PTR_TO_INT,
> +       .arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM |
> +                         MEM_UNINIT | MEM_ALIGNED,
> +       .arg3_size      = sizeof(u32),
> 
> MEM_UNINIT should be removed, because
> bpf_xdp_check_mtu, bpf_skb_check_mtu will read it.
> 
> If there is a program out there that calls this helper without
> initializing mtu_len it will be rejected after we fix it,
> but I think that's a good thing.
> Passing random mtu_len and let helper do:
> 
> skb_len = *mtu_len ? *mtu_len + dev->hard_header_len : skb->len;
> 
> is just bad.

Ok, fair. Removing MEM_UNINIT sounds reasonable, was mostly thinking
that even if its garbage MTU being passed in, mtu_len gets filled in
either case (BPF_MTU_CHK_RET_{SUCCESS,FRAG_NEEDED}) assuming no invalid
ifindex e.g.:

   __u32 mtu_len;
   bpf_skb_check_mtu(skb, skb->ifindex, &mtu_len, 0, 0);

Will spin a v5 then.

Thanks,
Daniel

