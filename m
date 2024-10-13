Return-Path: <bpf+bounces-41822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7C599B86A
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 08:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B4B1C2048A
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9A981741;
	Sun, 13 Oct 2024 06:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSWUREjF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52D2E406;
	Sun, 13 Oct 2024 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728799577; cv=none; b=P03uY/vWwlWy9DLPcBINYsnaOkdxHC7qHc8e/YYKH+nEyI405BVZDk5EAYfRg81baoOVeWuKZezpAacl+sca+RG02wnuWDytbSCgtjOmSzskE3B8ARW7WLnHlvD3EUpKyd0yW/QseIZWAO0QhgZAtg4M0RKXfkEdbN50f2uA6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728799577; c=relaxed/simple;
	bh=Fmf5Oe34tGT1Da8S8SsfkMXstT4pOKmcQHklchR0EJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0fPUaYnQVti+lccjEN2BHwtjoriEBDS+nmLHEDBBOV99NPOLKFGfqcjNnHf+3ste4XgcOkutS6z4Xdayd2OaGp3lIiqFHcIbHV1kitmNknKKgUzj23N+WJUqEM7TDcbP3r90geaqPaJevcX/KUs43lf1BPyqUxEwQ3rruOcjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSWUREjF; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8354b8df4c9so113449139f.1;
        Sat, 12 Oct 2024 23:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728799575; x=1729404375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gnxrE3Yvm03jjj0jNaq11fJdS+HVMoZrq1TgWsDd7Ug=;
        b=jSWUREjFPzinwL+XEuwGS0t7mV+zUygTMfHan7zBJZMbZEVcldRpnuaiASvpjdyAhC
         a9IRBNUMFrwpxhxvBrNdiiwh54h2v0moVFNBXFd2M/I/kwoqMubtEQ3wkeRec3uUowId
         iG4aqzlNEYyRFDoGerBx/To6npkV+DEHIY/TZpYxAaDQGMSyYILXOwk2exTTsQEysUup
         XDmj5EB6mANkGOFCjW4vtPqM1Tf5YAnlvn0oBwFilLdAt09TwGGfebt3jus0cUx6MjQH
         DsjS++IyagrGxPjEEehVpHF5Ji/QSRZkUgXyMHw5KTZvQ/SRUQQan2mfHBiabxvgh/N5
         Sgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728799575; x=1729404375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnxrE3Yvm03jjj0jNaq11fJdS+HVMoZrq1TgWsDd7Ug=;
        b=OU6L9IaD+hcuZvyzQ3gOMe7UaKVoqkNGebM6vxkWxxMILA4pAZyAhrq4coGp08drhP
         B7t/celu8ZsxhCjqsSDUoGR23nx0hMYU14rweq1HOVL94KtvNMkTYVPJfhNF6G7KHb3R
         YtQJg9LQH0MeVPjJBtlLfA3uQ3wRPpE8JV0v/BtlG9fSIOUq4+V2vUe+DeH02DOphkLi
         QeSS/qf8ptX5GEdhAOQ6ZwVRApQ6YlD4ut6UvysOgpEg8Wm1U3AIpzGFNe9JzsUcuLtr
         uYoxU5taJcO+ZGuPE+eDGTNaCC02SgrcQ1iv76XDqFZZX1MJnC37smMYr9ZwbsXe0Tb9
         sDIw==
X-Forwarded-Encrypted: i=1; AJvYcCUgm0hiTZ9pt+aICvbfraJartIwILO7imWi0BCcWDNomOYNkLoS3/qpFguJXAdpfaY1Uf4=@vger.kernel.org, AJvYcCUjcvpYBE4MO6FXTinpDtD8XOdblVpUBoWwPkNvgTFDH9gRnQWhk5x9ihySgpL0tMA5PZ3aeal0@vger.kernel.org
X-Gm-Message-State: AOJu0YyWwIFd5uI8XWSD+smV2EtDhcYeqKnh0W91/pzms+/GLUwUkvQ9
	mdSOC0sbXpvh+BsucuQ6Ou8MQCTJK56vElQWOaBzBaTRj/HjtdT+HfZmLKK2FCcAZYC1TioFAvE
	RNGAtwEhRVqaWt/Krrj2EfxNjyaVgjC5H
X-Google-Smtp-Source: AGHT+IHjAlYtPnOHfkI1YQY5/F2Bag+jyBNrPTP9M1jj2Rx+3unj849hdMlb1guxcHfwrzLEd1QQoREtA1X3LPs6oKU=
X-Received: by 2002:a05:6e02:1446:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a3bcdbb5acmr35808605ab.7.1728799574997; Sat, 12 Oct 2024
 23:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <670ab67920184_2737bf29465@willemb.c.googlers.com.notmuch>
 <CAL+tcoAv+QPUcNs6nV=TNjSZ69+GfaRgRROJ-LMEtpOC562-jA@mail.gmail.com> <CAL+tcoCwQpM3mMsB3Trw0XrHoLcHqSFxU1LSs0AxUyiZc1wNgw@mail.gmail.com>
In-Reply-To: <CAL+tcoCwQpM3mMsB3Trw0XrHoLcHqSFxU1LSs0AxUyiZc1wNgw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 13 Oct 2024 14:05:38 +0800
Message-ID: <CAL+tcoD-595iMJ79L7kVUsMgBfjnTQJgPaycOw2iP-nUDHCivA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] net-timestamp: bpf extension to equip
 applications transparently
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"

> I tested this by running "./txtimestamp -4 -L 127.0.0.1 -l 1000 -c 5"
> in the bpf attached directory and it can correctly print the
> timestamp. So it would not break users.
>
> And surprisingly I found the key is not that right (ERROR: key 1000,
> expected 999). I will investigate and fix it.

Ah, I think I know the reason. In this series, the BPF extension
allows setting before sending SYN packet in the beginning of
tcp_connect(), which is different from the original design that allows
setting after sending the SYN packet. It causes the unexpected key.
They are different. The reason why the failure is triggered is because
I reuse the tskey logic in the BPF extension...

====
Back to the question on how to solve the conflicts, if we finally
reckon that the original feature has the first priority, I can change
the order in the next version.

void __skb_tstamp_tx(struct sk_buff *orig_skb,
                     const struct sk_buff *ack_skb,
                     struct skb_shared_hwtstamps *hwtstamps,
                     struct sock *sk, int tstype)
{
        if (!sk)
                return;

       ret = skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
       if (ret)
               /* Apps does set the SO_TIMESTAMPING flag, return directly */
               return;

       if (static_branch_unlikely(&bpf_tstamp_control))
                bpf_skb_tstamp_tx_output(sk, orig_skb, tstype, hwtstamps);
}

In this way, it will allow either of two features to work. Willem, do
you think it is fine with you?

Thanks,
Jason

