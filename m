Return-Path: <bpf+bounces-16350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B58800391
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 07:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D669B211E0
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 06:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF5EC13F;
	Fri,  1 Dec 2023 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3IpWRwc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93220D7D;
	Thu, 30 Nov 2023 22:10:59 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d7eca548ccso106415a34.3;
        Thu, 30 Nov 2023 22:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701411059; x=1702015859; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcGW2snvrekVzF3EzV8UgTK2J7ldfnV3vnpkmjMkLSI=;
        b=j3IpWRwc8oT0M15H09FL4blCP6vakj8aa2HAKixTsvGUj3DwOXe4cLShYoTfhEuQ10
         ymaIlA36RC8DSEAtGT/Yd2x6OPxAfr8th1Dzfq6wmb2UkXW4s2vKOR//Qz9h1Po8e4vz
         kLJJe4RuIKmzLNWCCn95Cof8cZvt8QE4pIlwYLDr/HoFZ25jzum7fTefSNG3p3dKVJ0L
         roBdBxHT3Ef1ZCUYMtWzOE+6yXTLbdARGeN161Ik8SoG/pwSe0p0NYcA0cugtkpPt748
         D5bc832ki2cgKd2s+hKdV0s/2xXtkXE68tVp7DD6g5jlKuFMLd+3OqBCmxJ4HArhoeEd
         QE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701411059; x=1702015859;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcGW2snvrekVzF3EzV8UgTK2J7ldfnV3vnpkmjMkLSI=;
        b=mFwkocqehMn2lBf0IAyZcdofrTDIbVDPi7MeqWI0OzPUjMLIvOqam7mJwN8gVOCeoc
         ENSFttcDEW1i3ZgAtrBvBz06b/5p8SIr6P3iWgzja/v60IBwN8wFVY1Q6kcKYnlCYv7o
         pJq9ge+1FWNJsmd6JeHn3BfF1uPuEuXsLrcDmSB2qb/2EaxAw18UBFhWSJ7X3rWjzlxx
         HNFhQOkTEOEKLeF5pXwswzjvqtEBkj+BtKhnyphD/0oUZ18FGt5cZA+5DI5L41C37Hfs
         kbeSYWjQHb9IcfTvq37L/4X9sgeaIy4osv+KaFJdOar0qqDr4J0w+4t+33psaCURIJ6W
         PViA==
X-Gm-Message-State: AOJu0YxQ1qSYK1sMUWjeaMCGerO0RWlaNvVQMGKgITPDMuwCuXtIggac
	jf1bGv2b4Q3zDJKxxLHvRG9lUtfRWXFtJQ==
X-Google-Smtp-Source: AGHT+IF7eEa0FQ5QJc/9nVcOdakEOUnApQFTiz7lKHACn1kw2hkwvtk+iF8pHtDhShT6d3v5Uchbug==
X-Received: by 2002:a05:6870:2189:b0:1fa:1719:dce2 with SMTP id l9-20020a056870218900b001fa1719dce2mr27978230oae.28.1701411058743;
        Thu, 30 Nov 2023 22:10:58 -0800 (PST)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id i31-20020a63221f000000b005bd2b3a03eesm2259837pgi.6.2023.11.30.22.10.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2023 22:10:58 -0800 (PST)
Date: Fri, 1 Dec 2023 15:10:52 +0900
From: Yewon Choi <woni9911@gmail.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: threeearcat@gmail.com
Subject: [PATCH bpf] xsk: skip polling event check for unbound socket
Message-ID: <20231201061048.GA1510@libra05>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)

In xsk_poll(), checking available events and setting mask bits should
be executed only when a socket has been bound. Setting mask bits for
unbound socket is meaningless.
Currently, it checks events even when xsk_check_common() failed.
To prevent this, we move goto location (skip_tx) after that checking.

Fixes: 1596dae2f17e ("xsk: check IFF_UP earlier in Tx path")
Signed-off-by: Yewon Choi <woni9911@gmail.com>
---
 net/xdp/xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ae9f8cb611f6..1e5a65326d1d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -947,7 +947,7 @@ static __poll_t xsk_poll(struct file *file, struct socket *sock,
 
 	rcu_read_lock();
 	if (xsk_check_common(xs))
-		goto skip_tx;
+		goto out;
 
 	pool = xs->pool;
 
@@ -959,12 +959,12 @@ static __poll_t xsk_poll(struct file *file, struct socket *sock,
 			xsk_generic_xmit(sk);
 	}
 
-skip_tx:
 	if (xs->rx && !xskq_prod_is_empty(xs->rx))
 		mask |= EPOLLIN | EPOLLRDNORM;
 	if (xs->tx && xsk_tx_writeable(xs))
 		mask |= EPOLLOUT | EPOLLWRNORM;
 
+out:
 	rcu_read_unlock();
 	return mask;
 }
-- 
2.37.3


