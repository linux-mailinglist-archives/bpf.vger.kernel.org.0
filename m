Return-Path: <bpf+bounces-43250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF499B1AF0
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 22:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B431F21F2A
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FBD1D7986;
	Sat, 26 Oct 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIXAMrj1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8521534E9;
	Sat, 26 Oct 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729975034; cv=none; b=QHXHrA5DC2VpgDZfPbZW4ib0xZ+cmS1lsOfjcT0knCXvfvwZ4fsuBw3r2OSYw2UsabmkrfMMXVh7PbDKxqnd+OdY1GXl+OoL5m2s/2hSYZHvenZbRdOykpq0WGAGTrHUKYMjmuh50osCriINlJmhDdtyc1jvQ6f6xaDsl4I0+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729975034; c=relaxed/simple;
	bh=HI7ity/oa/ka9cv3V8FDOAD5p0QTO9Jgh7DeocJ5Glk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4u3lpfUQoDX8ERe5Y863jZDKJpTI+M2o/pmdlcmcEoEwCH8imi6rK8rdVgM+LcOMlHQybRATvf/HMu2eNy/YVHDaZmTGTj5klW0VurPmCMJz8d+1cH00BZylnLKTf2vJIbEt2FPMpEUet4ElkwUHd0Gs59jrukoh6SCALZ7l/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIXAMrj1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so1164701b3a.1;
        Sat, 26 Oct 2024 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729975032; x=1730579832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aR5yj1+V/MTixDnxfXpOMwrRd/ZzgiDUoeYFWdOL+aM=;
        b=SIXAMrj1sQpCqkMGlDnswd4uF3JXatn+rR6IxO4uXFDQyjUhTeMWncJnfcwNeZ/lkT
         RymxhSwUnFqbgZ3o1vqZDlUDbysdW4KXS0+kUM/1lfT6q0lQN+OIJ3d7kp2Emnf0lfzW
         lnC/ZobFaLJmWSO6hp21xVQr7FRJ/aeMN4SDDc05bg/0+BD/HPZvvYiUTSWSQIO5pCnf
         7ghX27bERknkjywCgT1KUlQCXbUQc2nLGU75MPWJsEN2CHz3PFZwuGu6y+OvJXN9VEPN
         JfRPMN5M6P9xO8MNFbSfnY+Uu2fOo4FF/4719xVe5iOwD+zERRjacPf8fYdcNlaXgBWz
         b3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729975032; x=1730579832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aR5yj1+V/MTixDnxfXpOMwrRd/ZzgiDUoeYFWdOL+aM=;
        b=Ur3AmjRFfdERdjSRTPgsp9eDxg4/pQA50IfksG4bk9il1I6qXMgL6janjUROtTFS2h
         W6jj+3t5e+R7xKetAi8nTNMkYXnF5Sl4dOdiiK1RJGshSPAFvL8X5FdY6sn7H6JwCNQh
         IOOFnwwfP9fWPi6jJozQ5oEWHpvg3ciGiLyaiaDSL7vac/aZTw6iGvwoT9sBXQhpELHr
         ZbEFkBho0OKr45eIar3FeOlPKlSfp7z2C7K+Ex7/LuGsQPOaP051wJ/ekt1JmPgqNpvP
         KMpBexsvyUHIUMB534AE5sDYCcfSwSypRKyXumqUigKEksavQwSIMOv9R63ymCNmy9Kv
         0q+w==
X-Forwarded-Encrypted: i=1; AJvYcCUZr04eTubZVTebMQjXQHxbGLql5EMZhyN7SQQcXUlU25Qcs6Idf3CBx+dd7IcNImBNI/AhFFnVZQi5dAA/@vger.kernel.org, AJvYcCWrxwZnoMLqwKqqo/g0lrSMR01LKYRMbMH6K84b9I9m6laYK0sol7PhOGvaNOaCUIq6b+2qF4lJ@vger.kernel.org, AJvYcCXedIN9tD4lDL2pBsdcC3/jtKShjOT14DMJcjY7JraS+ZrprZz04qk9My6Zk2N6q4Vin+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSc9St0xlQW6NIVQEMHQw5YfgweDql6IrklIfb9daXLBJY0yc
	OXDZCdQaoldRrRqn868nlHVClnA6lgoF7jyN4oCRq3cmH/dvciYt
X-Google-Smtp-Source: AGHT+IHPKiSQ1tUBn1Eiegpqfrg4lY2oC+XAepMwaiU3T/MqZRANFXm+bERVSZtum3QIvf/HkTf2RQ==
X-Received: by 2002:a05:6a00:2350:b0:71e:4ba:f389 with SMTP id d2e1a72fcca58-72062f83c5amr6073389b3a.10.1729975032160;
        Sat, 26 Oct 2024 13:37:12 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:6bce:bc57:7561:fc9c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1fb1esm3090123b3a.155.2024.10.26.13.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 13:37:11 -0700 (PDT)
Date: Sat, 26 Oct 2024 13:37:10 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: mrpre <mrpre@163.com>
Cc: edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: fix filed access without lock
Message-ID: <Zx1S9vf2i7O+BNE+@pop-os.localdomain>
References: <20241021013705.14105-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021013705.14105-1-mrpre@163.com>

On Mon, Oct 21, 2024 at 09:37:05AM +0800, mrpre wrote:
> The tcp_bpf_recvmsg_parser() function, running in user context,
> retrieves seq_copied from tcp_sk without holding the socket lock, and
> stores it in a local variable seq. However, the softirq context can
> modify tcp_sk->seq_copied concurrently, for example, n tcp_read_sock().
> 
> As a result, the seq value is stale when it is assigned back to
> tcp_sk->copied_seq at the end of tcp_bpf_recvmsg_parser(), leading to
> incorrect behavior.

Good catch! This makes sense to me. Mind to be more specific on the
"incorrect behavior" here? What error or misbehavior did you see?

> 
> Signed-off-by: mrpre <mrpre@163.com>


Please use your real name for SoB, see https://docs.kernel.org/process/submitting-patches.html

Thanks.

