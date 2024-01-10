Return-Path: <bpf+bounces-19314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F3B829487
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 08:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B093E1F27C5F
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 07:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC33F3B790;
	Wed, 10 Jan 2024 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPEoc4Nm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273C3E460;
	Wed, 10 Jan 2024 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6db0c49e93eso1286106b3a.1;
        Tue, 09 Jan 2024 23:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704873211; x=1705478011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlVkfwSR0KhVQsqSLqhfZx1Bsn/0daw+ebFcj5qo+4s=;
        b=gPEoc4NmfrP5CJJDz4T0d0LEDfhfQiBtGMmTQ2Uv9kUEbzE2TO3cYAhclCbBTIe8YL
         wN/VPJoHz0NQ6RtElvF7ajaIpFe/NLbvs8/xi2/0CZyIsvn9LCqxsTYfhsrmlnjWthwf
         gmkqPozUxl6FOmq597M9AW/Be7/w+iTQzCzYYMfyyHWwS1KSNd5FMom5L75kccdmAkiX
         qgL1pOgQUTib358g1jDKFd81lTYsvTI548uwQF1b9ZnKCMSFpTYm0opwo6prMTFFysUJ
         PrxVPq3uoETu9a1KNQTs+H084vFa+h9nZpVxfkSkuwKzF9FsfoYuiNo1MVxVwOsvj7JN
         l9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704873211; x=1705478011;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DlVkfwSR0KhVQsqSLqhfZx1Bsn/0daw+ebFcj5qo+4s=;
        b=VcItm9MmmEBYAPtsEGT+GRiYLasHaT7cUSe6feizm3j1EW1zMQQejBHHidTaCvY32C
         vq/M6atc/b9vH43/qOsB992xOl7TdID9LSPxsV+uDos8NcmSgxrOTh+KaH5fxSDW/8Dd
         EhCJXKXXmVHHA0R71O4+NDgsR/qmN1PdVhVDxLAn5WEuNM4UhayRvDKxvaaPh7A/F2eY
         UgxVxlqEfMAwazU0nuBn7hfmUA7HuplZDJXwaFB4PTgPZqPRGAClAdD2uEn9qyqjWo6W
         njrZvxk9bJXLAhFslMsIHXmM0anj8Ai1GMVZLn7Ksd3npkxfPGeSGB3Y522sIPYXVYya
         IsEw==
X-Gm-Message-State: AOJu0YwhiM8p0BjzACGu9PtUi4yKXjrBRZsZQ88sOh6VZ7QZJC6xtIfB
	fK2fREbPfG46BVsstD4YEMA=
X-Google-Smtp-Source: AGHT+IGef+AIUYFPUgDh2F7pkq6gUHNd12WepVFH29+8g1TMJjZTSpFBb+q96we/xyvmH44Lwl3g1g==
X-Received: by 2002:a05:6a20:7883:b0:199:76d8:402d with SMTP id d3-20020a056a20788300b0019976d8402dmr508563pzg.111.1704873211316;
        Tue, 09 Jan 2024 23:53:31 -0800 (PST)
Received: from localhost ([98.97.113.214])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090274cc00b001d4301325a6sm2974264plt.247.2024.01.09.23.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:53:29 -0800 (PST)
Date: Tue, 09 Jan 2024 23:53:28 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Edward Adam Davis <eadavis@qq.com>, 
 syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com
Cc: andrii@kernel.org, 
 ast@kernel.org, 
 borisp@nvidia.com, 
 bpf@vger.kernel.org, 
 daniel@iogearbox.net, 
 davem@davemloft.net, 
 dhowells@redhat.com, 
 edumazet@google.com, 
 jakub@cloudflare.com, 
 john.fastabend@gmail.com, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 syzkaller-bugs@googlegroups.com
Message-ID: <659e4cf817b78_60d7a208c3@john.notmuch>
In-Reply-To: <659dd53f1652b_2796120896@john.notmuch>
References: <000000000000aa2f41060e363b2b@google.com>
 <tencent_146C309740E8F6ECD2CC5C7ADA6E202D450A@qq.com>
 <659dd53f1652b_2796120896@john.notmuch>
Subject: RE: [PATCH] tls: fix WARNING in __sk_msg_free
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

John Fastabend wrote:
> Edward Adam Davis wrote:
> > Syzbot constructed 32 scatterlists, and the data members in struct sk_msg_sg 
> > can only store a maximum of MAX_MSG_FRAGS scatterlists.
> > However, the value of MAX_MSG_FRAGS=CONFIG_MAX_SKB_FRAG is less than 32, which
> > leads to the warning reported here.
> > 
> > Prevent similar issues from occurring by checking whether sg.end is greater 
> > than MAX_MSG_FRAGS.
> > 
> > Reported-and-tested-by: syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  net/tls/tls_sw.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index e37b4d2e2acd..68dbe821f61d 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -1016,6 +1016,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
> >  
> >  		msg_pl = &rec->msg_plaintext;
> >  		msg_en = &rec->msg_encrypted;
> > +		if (msg_pl->sg.end >= MAX_MSG_FRAGS)
> > +			return -EINVAL;
> >  
> >  		orig_size = msg_pl->sg.size;
> >  		full_record = false;
> > -- 
> > 2.43.0
> > 
> 
> I'll test this in a bit, but I suspect this error is because even
> if the msg_pl is full (the sg.end == MAX_MSG_FRAGS) the code is
> missing a full_record=true set to force the loop to do the send
> and abort. My opinion is we should never iterated the loop if the
> msg_pl was full.
> 
> I think something like this is actually needed.
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index e37b4d2e2acd..9cfa6f8d51e3 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1052,8 +1052,10 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>                         if (ret < 0)
>                                 goto send_end;
>                         tls_ctx->pending_open_record_frags = true;
> -                       if (full_record || eor || sk_msg_full(msg_pl))
> +                       if (full_record || eor || sk_msg_full(msg_pl)) {
> +                               full_record = true;
>                                 goto copied;
> +                       }
>                         continue;
>                 }

Actually, it needs a bit more than above. That will fix the warning,
but it returns an error on when it should flush the full_record in
some cases. I'll send a fix shortly.

