Return-Path: <bpf+bounces-78488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A6FD0DDA9
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 22:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A4923032CF9
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 21:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E492C21C2;
	Sat, 10 Jan 2026 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DBNT229l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18452BE05A
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079141; cv=none; b=QmMrc3bFHzL2NUOPUTh1hsuudtandMRo/i7ZEiYRq+eQ/uX3kjPrfPQg8h26qveVaSmUM6vAevhbzvr8yA8MT1acJXOAg0CVoxNqf2iIopOf+WC67YQM9tel7xZoROa6VTWz8qTiu2GiQCNZo8x0Qd4gQ0Tsavb/t1w+LuB1u2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079141; c=relaxed/simple;
	bh=ScmD128+xpbqw69NFH/JoFUcpX6jwb7UjOYs0lYQUDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XaVBzZzHd2Klq2ubvP0sxmDxuhViXIG3Pip30/W6SCgB3BMoJZuRl92ypsjJfh3uQDS0Y+ZNk51bt0lCpzJfS8agWcPNu//uUBjZcR+llmzHVPG0wf+EQgdXq1xBgZB1Q6RVYDsV94tXf83KoI3sicVaCjuECfj6FqoinOKnd1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DBNT229l; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b72b495aa81so1005389866b.2
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 13:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079132; x=1768683932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYcerOXvT20TAZxV32Bgec2U2gzBl1lA7Z10rFU3rY8=;
        b=DBNT229lu1Np6sGwYn/sIMmOFXN6dm1h74VFfc7H/6XdBBTJZsmnfhmzUHLL6Hx6UB
         1jqs6dLeSCNsCjHN+Aa/1XEOU2lOlplWZBC2dMOfK1IYl9aeEBIM/d8Sx3oQK3yvRSdK
         jt+JEpSm/0qNejMhCYk55Cf1lsGzYeeJ1K8uquWuinUJDKEexCCtpBb5nZf0puVyO8eK
         NysUSam7QFIEuorQAD1J8gBTJtIhyxKwE2BOzmXoFzAwgECmWdNxJx74DzAEZoICrx/g
         Mnja2HJ4AwaMKUZm65ipo1teVak2w/+oojZxBlimrbZdkbUkXjBL8DSDvey/8I2X0gSQ
         bBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079132; x=1768683932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JYcerOXvT20TAZxV32Bgec2U2gzBl1lA7Z10rFU3rY8=;
        b=rk3qb0A4nxMN6A1wo8QWSlakJbCK3T480w4vfBu/7y5LDe//jvIaimZkfcS1CYl/7o
         b5MnMpBABkZ0KRd6seTvWlPJN4gyt02jt8tnOe+DQD4imClMjn60hkIxrwcfeB0HxAvz
         MZ96B6u82hTwuc0XSJ1BBf3K1CbKhXP3h55lyOYV0QI3EnghOAZu5qn/7qxKZ9bVGUoo
         A5eJ3PqxfqBUBWGn/X3S+vJVDsciP0RDYOOfJLCG1fUM80vT2nVOOBaCqtyTolIgiNNx
         IszD6C3G6dYHR9cEignZTsDE57bqNA8LVy7awZYYiFcDlveYkmKJm787NJufd8MYf9Na
         i7XA==
X-Forwarded-Encrypted: i=1; AJvYcCU3w9cN/Y6b+e/PXyjdNGF+4Ahfj3YtxvNtv7hbv8GBvLRIcOHSHYBpKXQqz5jVsDLjitI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJq1GPRN1xB5U8+Gg8PggA4EKBt0QFV+ffNAejbaD0+6i9drL
	Gnhj8KDBfZmeik8EoazlfhvJVE0VjA2TEJZ9i+eobAAUkIMJjhWdFV0Q0JIRaVQ2iAj5oeGy8mZ
	WD2gr
X-Gm-Gg: AY/fxX7t0WmU0Pfvhnk0K9292S8Xgn8MxD+8JOTZhVrRq8tqwd1TBeuZoyZsXQBWmx3
	WuGUihM5pYCbhlVHqo8aWPdFmx7Vmuj2X1YTgyKvCeOi/4wlPbm7HrcIokL3Czd3GquuKbkrowW
	hanUuAnYMzpoaCvr4bawUOTUqge6qqNPN5+ze4sYcCcoRZqd6pBKxoBpQPHqls59qr+rTyDpIJo
	7QrQ9ijrJbCrdYwMUB25aKGvHMzo9ISF2//PkltDaCohquSdLeV/rFGitjCgzbdP3AUfY0iOMdB
	d2H9aLugY/HRBQGFNY8hzjL2v3gS9CeCUU1m2HZhmx4j+w6rHMJrCOOPtln0dXYEpczwhLRECN3
	2g3BVP0Y4U7hT4sEsy6XVa0JCyRGu8Zhu7FBlWdReXljd/2cAXwD5KmGwsELqPa4a/z0fpe6tB0
	AmuZjwKuJ2FaDq89IPbTMXapGTl/bPAX6eVych3idWxLutA7J7IEkjfZ1OgQVO2cfRAnY7kg==
X-Google-Smtp-Source: AGHT+IEFuKrUoamrVGukylQDbXiei94tsX9UTPR1SSJ/HUiay/bcZTQi78J/wZJ2myAmZPltA3HFYw==
X-Received: by 2002:a17:907:72d6:b0:b73:42df:27a with SMTP id a640c23a62f3a-b84451edb4amr1195769266b.1.1768079131992;
        Sat, 10 Jan 2026 13:05:31 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c3f89sm13718558a12.5.2026.01.10.13.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:31 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:21 +0100
Subject: [PATCH net-next 07/10] mlx5e: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-7-1047878ed1b0@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to copy the XDP metadata into an skb extension in skb_metadata_set.

Adjust the driver to pull from skb->data before calling skb_metadata_set.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 2b05536d564a..20c983c3ce62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -237,8 +237,8 @@ static struct sk_buff *mlx5e_xsk_construct_skb(struct mlx5e_rq *rq, struct xdp_b
 	skb_put_data(skb, xdp->data_meta, totallen);
 
 	if (metalen) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	return skb;

-- 
2.43.0


