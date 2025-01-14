Return-Path: <bpf+bounces-48761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6AFA10553
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 12:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4BC7A227F
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445C284A4C;
	Tue, 14 Jan 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GHSK2Ku9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB9231C9A
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854072; cv=none; b=GUbyCbSBKkbo/FfMiuzz14tad8v9bDdkDCjEQc+lx+fjoljUn2RVtddgCKLbzaQsGoGB2mcw2i8a7TSmNrhHbEcYxQhRLYwbGIRoj22apOBtT44xBa425i2KNrb97HlaHvVsIY8omIZil2d6BwK5nGdonBPPItazELOApg0712k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854072; c=relaxed/simple;
	bh=qzv1F7wFVtGQZfLI/M84LNz+pssuzOPCwN5kUXDtkTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hddPbElWwtp2u643rFeeV93QPwtTvL0W6ATmgfBO3aeCvqBFDVOknwvj5TaEb6CF4HVfckOm6RvzgIkpnZglR0oOiF8RYtqaosDRWyD+lAGtla/MP3aXCFBZWGqfCFzOvFQda2zn/xSbR02PTvJ9fGzq4rXLGoEvz+pIKbK1BOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GHSK2Ku9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso928133066b.1
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 03:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736854069; x=1737458869; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzv1F7wFVtGQZfLI/M84LNz+pssuzOPCwN5kUXDtkTU=;
        b=GHSK2Ku96NrNg1AXcETqcVbZblLiUhb0ELvN9ldUA6o/UNUm+boYCwmQBr8oLYxKM/
         iisa5GF4tfkiucUD7gR1naqzbAAaj+5YTMXltiLwT1rXE5oDslzDjbqN2fidbDcAjUxp
         /nbhKd7ytq97me0WO6ZdiUKfnMxvDTCvThkFsBQLyCvs6nAtwv0SfuotxZ3LZ0CUR0ua
         YfBxTNZIAKuspNawH5sPDddToICwAEH6Mbga1YkzXqOy+ln26E0iOZiqPHuXEo2dgTMh
         iUPccvOhkKrRgAkp1/FyBSnG8OzRn4LDWuOujsqCGk2N2hLzu71Im8FFDOb6ugNSVT1W
         TUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854069; x=1737458869;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzv1F7wFVtGQZfLI/M84LNz+pssuzOPCwN5kUXDtkTU=;
        b=RmIWi/b2greN6Nf1/R1Sd+5bHvsaQOkBtfDcUw9o2wniVwDgyMfsaDE+UAAe5kRhMy
         kHOAaXyp54vg/q91Q+RVV7RAD/D+FROepf7P25kz/Kj4JR2THGeoQUE2uoExKZz05tdY
         2S++b23KvYqBYStZ1uu3h9Ky3nOGfcTWGIr9r3AD55gAP11J1uy833ysyqzl4MTzX5+5
         aabrU520wnd//66N551hOO0Ub12TI66tqgeSJd1jc+ja/CfmurwHgYpNvAIPK+Anb1YJ
         rEDthQ8sJI9cQ8R9+kUf+BW2owmKxzalANxTH0hgmrHYxXM8PIFS/njiAlFWu/k9VSJb
         Nkzg==
X-Gm-Message-State: AOJu0YxXSluhaen8furHQ4skSycPWX5Q27s3+N+INHpX0t6+OpO/kEJ1
	mtHmURZrAE1TSzch7+HXIQT7FPqtTliDjq9A3jL0NvXFFNIraizaBXaACXDkdx0=
X-Gm-Gg: ASbGnctRW6NzalUS86fGQS76azl4/EnMpHoHfesV86OFU3L5kXads8llqQ7YW2tcp5V
	TMImXNZUHp0zicvAYZOGHNpXVIF4ZdCfBDzBVZZE7UvnCXo8doYGbRptpJ5toRqck/AlS0TSJGt
	XAKheXLIPnooXpfbfVlD4sjHXjyhIK2I8mZi9OalrQyWw3Ix+EaGntKAkrLQlcXbnkQdDPlIDRN
	109YbBTVYTeQanW8EeNNbFU4frIm+rPtSB3GcLPqKXuSlOr
X-Google-Smtp-Source: AGHT+IHkpOB6+6LEPaHrWYFHACEx+4G1Y0bKkva9Qoilv4G3mQbxLoysCGBGVXfN3SzMOk7JekHkvQ==
X-Received: by 2002:a17:907:97c6:b0:aaf:208:fd3f with SMTP id a640c23a62f3a-ab2ab558911mr2266993966b.13.1736854068937;
        Tue, 14 Jan 2025 03:27:48 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5ba0:d60::49:173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905f04fsm618819566b.27.2025.01.14.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:27:47 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v5 1/3] bpf: fix wrong copied_seq calculation
In-Reply-To: <20250109094402.50838-2-mrpre@163.com> (Jiayuan Chen's message of
	"Thu, 9 Jan 2025 17:43:59 +0800")
References: <20250109094402.50838-1-mrpre@163.com>
	<20250109094402.50838-2-mrpre@163.com>
Date: Tue, 14 Jan 2025 12:27:46 +0100
Message-ID: <87o709eitp.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 09, 2025 at 05:43 PM +08, Jiayuan Chen wrote:
> 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
> action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> the update logic for 'sk->copied_seq' was moved to
> tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
>
> It works for a single stream_verdict scenario, as it also modified
> 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
> to remove updating 'sk->copied_seq'.
>
> However, for programs where both stream_parser and stream_verdict are
> active(strparser purpose), tcp_read_sock() was used instead of
> tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
> tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
> updates.
>
> In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
> in both tcp_read_sock() and tcp_bpf_recvmsg_parser().
>
> The issue causes incorrect copied_seq calculations, which prevent
> correct data reads from the recv() interface in user-land.
>
> We do not want to add new proto_ops to implement a new version of
> tcp_read_sock, as this would introduce code complexity [1].
>
> [1]: https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Co-developed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

No need to put me down as an author.
If you want you can me with a Suggested-by.

Also, please remove my Signed-off-by.
I will review these patches, but I haven't authored them.

