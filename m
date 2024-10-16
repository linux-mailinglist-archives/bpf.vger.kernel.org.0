Return-Path: <bpf+bounces-42214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A699A1146
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 20:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9803328628E
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6023210195;
	Wed, 16 Oct 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk5CT1Je"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E618870B
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102253; cv=none; b=FKlaUbiMpJzZmSieYYTnSpUxh5Bw7iw3boNQoXXobLpuwyRu+3fViAEf4cLFRiz46WpnoXTrrsYc8kTHQNw/uzDQf/Q4WOViW/GltDB2WythJ1FrHYtsRJqi/oiUUYYK9/VKyyLzWj2S5IKBGg/UAqmt3+nxBXQ/jIodlQ/5Z7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102253; c=relaxed/simple;
	bh=2ArH51OGQm1oxRY7/ZCctOYIUMnY5OINNDqKfYxRw2Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PoYXIC+ZSns+FpfUx56DxTyW9a3YLjWoy6DgRsxQuU8k+R8Tu+nh2yTk3FNqTXOCexesISBdmKvnpO+2dLICqFxsDLo7w07UJIuB8HvH0plAu3BPDT8l1sroXoZckWbcbaOr6EOyMrkwz1JXJKA9teSOh6fF9qbe+VAPrY+IgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk5CT1Je; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c803787abso907505ad.0
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729102251; x=1729707051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4zKzYeuFG4JUP3psfyv2lcOrsZh59tiErm8IBz0FxE=;
        b=Lk5CT1JeIAdyai+v0mwNU30kO/re6hljN1i8xPqMGlzNAjDbJd3W8XrlMYJdvK7JOL
         NDWwuxl9Hyp/uz5ofI6fSGLmCs6W+3EkhKbnE2Ardz0lSBKVd70uc/N3QWPcfHzdWiPY
         aQ6BwRhx4Mdku8JslXZd4firSv4gKOaOcP58Gw9C8heGJFQUYTBSYybOd49VZBdGVzpB
         CC6hGW8UEqNU+VpWyEWR+lQ5Qh6hdGHQzaZa8b6cnL91tXo9qKhnwQ2W0ujbOpkmfIwj
         h2sMDMb+amK3lJ+rPK4LKN8s9Rogl7tGjK5ieg7Hltsf3eIpI6VteRR6ICt1rR0qPA2p
         Jg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729102251; x=1729707051;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f4zKzYeuFG4JUP3psfyv2lcOrsZh59tiErm8IBz0FxE=;
        b=U9bM2RKvVFABFyCvsXbuf9Ul4mPEzy+JxyNyEMe/RJ0GrkvlfkouKewZ8GYWnsVFXm
         sqvb4sw8TxcV8VMzxnd90EzteZ3snXd5lH4wnjRPTLxqxCXAZLyPeuDlJ0OwbuegBsMV
         h8lQe4NtM8mJQHnrTB8LtxleXZqVFuUdLJYZtc9TD1PFv4HdP7hX+8/AWWInQpPj7nS0
         MIh6cwY8je20/g+u/gDWrT6O6WbkHvFyYdGzXT6o8sl70bCYi5JjXqOJ8wtEpL/CJ4Gz
         T2s4D47wRE3U2MHN+CbdSUz2D0iokdYPYMdtjlAmjRanv9W0B3PHq6rm6QblFncj0dku
         gibg==
X-Forwarded-Encrypted: i=1; AJvYcCWYd0mMSRqihflzron0/xOrCDxN2lpJWMb3n15FhyojwkREuwltgTrso6nOC0OOWk1T94Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1k+kOgY5J20XjH0WMHpjXFfjzwGfO5+ov+EtGLC48SOAcFtMN
	tlBrwnI21w0JiJIV5UsbiEmBGA5yg2vI6lI9PmVRIyyIQAJEDQZV
X-Google-Smtp-Source: AGHT+IE7ilqrd+cNZTuq6TAwTrd00eWz9f3tPsIIRvAO6k4krglPEULyTxQCT6jFTYoakLwyrs3+Hg==
X-Received: by 2002:a17:903:24f:b0:205:59b7:69c2 with SMTP id d9443c01a7336-20d4721b388mr6567485ad.7.1729102251386;
        Wed, 16 Oct 2024 11:10:51 -0700 (PDT)
Received: from localhost ([98.97.44.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17ec8f35sm31640985ad.0.2024.10.16.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:10:50 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:10:49 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: zijianzhang@bytedance.com, 
 bpf@vger.kernel.org
Cc: ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 bhole_prashant_q7@lab.ntt.co.jp, 
 jakub@cloudflare.com, 
 xiyou.wangcong@gmail.com, 
 zijianzhang@bytedance.com
Message-ID: <671001a983dd2_1e3420833@john.notmuch>
In-Reply-To: <20241012203731.1248619-1-zijianzhang@bytedance.com>
References: <20241012203731.1248619-1-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 0/2] Two fixes for test_sockmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Function msg_verify_data should have context of bytes_cnt and k instead of
> assuming they are zero. Otherwise, test_sockmap with data integrity test
> will report some errors. I also fix the logic related to size and index j
> 
> 1/ 6  sockmap::txmsg test passthrough:FAIL
> 2/ 6  sockmap::txmsg test redirect:FAIL
> 7/12  sockmap::txmsg test apply:FAIL
> 10/11  sockmap::txmsg test push_data:FAIL
> 11/17  sockmap::txmsg test pull-data:FAIL
> 12/ 9  sockmap::txmsg test pop-data:FAIL
> 13/ 1  sockmap::txmsg test push/pop data:FAIL
> ...
> Pass: 24 Fail: 52
> 
> After fixing msg_verify_data, some of the errors are solved, but for push
> pull and pop, we may need more fixes to msg_verify_data, added a TODO
> 
> 10/11  sockmap::txmsg test push_data:FAIL
> 11/17  sockmap::txmsg test pull-data:FAIL
> 12/ 9  sockmap::txmsg test pop-data:FAIL
> ...
> Pass: 37 Fail: 15

Thanks. Did you plan on fixing the rest next? Otherwise I'll add it to
my list.

> 
> Besides, added a custom errno EDATAINTEGRITY for msg_verify_data, we
> shall not ignore the error in txmsg_cork case, and fixed the txmsg_redir
> in test_txmsg_pull "Test pull + redirect" case.
> 
> 
> Zijian Zhang (2):
>   selftests/bpf: Fix msg_verify_data in test_sockmap
>   selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap
> 
>  tools/testing/selftests/bpf/test_sockmap.c | 32 ++++++++++++++--------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> -- 
> 2.20.1
> 


For the series,

Acked-by: John Fastabend <john.fastabend@gmail.com>

