Return-Path: <bpf+bounces-28913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BA68BEAC4
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78941F26019
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702BB16C863;
	Tue,  7 May 2024 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htavpb9Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1077168AF5;
	Tue,  7 May 2024 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104081; cv=none; b=M8XsOYyRzJ28h/qLS35gddZ/0I2YVt/GAV74Ltg+AqW+3uEixKoqFES2VqKtf/GlkUwL3hA19dfVqx31kZNNu4kSC2M564IwXhsd93zdoJEGSF7c+2O/UtcrHK6CHL2CGhEMPN8I/6NKsCuik3np5qfKqyYLob/ZODIilpodNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104081; c=relaxed/simple;
	bh=TjDPssNzTY8qWUgRS2QVPyoIl5gqGS3DWk/sWADBxfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bZ2jzzT6InYH1TZjZTHGB1uIBqoHRLgLfz43HwlhgUVqGkhQ3CB2fKl8duit3s3t/zFC8zl/45Fq922Cu4datTmZNpkREo1TyDEIx0Lw3vw/nxS+gpZiU+VVPr+V1wKu2EqBpXlqE+hwXoIYPJ/dfARTOOge1Do8DseG0HAwc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Htavpb9Y; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so2447183b3a.3;
        Tue, 07 May 2024 10:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715104079; x=1715708879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BB2/yyQRwxhXXSepeucMR5Q2a+hm4bu0sqJ9xoUUmRk=;
        b=Htavpb9YYlKHWUzSgUq7jy2060PLL5qI5BviHTH/xrtOv0wbs53MZddxvcq4Oc3Z66
         1ZKRLmft+IrFCGQdyGs/Bm/qaOw6Hw44hpVK4XIJqZzFWFaOS0Q58/gWh5wlwaoTTdT4
         Lj5aVeXHGjl/qfNyhIIHco51OOKAukO8nmHLvRs4gz1Te//+klLRBOIlQgnj0qrRI/K5
         JLrCYXwJOgSnYf2S/Debek0jkzFJIk9gENNV65rqrWcHWrbufrpGZ4lpSpSM/hbUYf5M
         6PjdCo6arRCPfLf58DOmMx4oq4efRk3huZjxdPz1U4qZhr0kPmaUHMGKOilA/3MrCgo2
         7ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715104079; x=1715708879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BB2/yyQRwxhXXSepeucMR5Q2a+hm4bu0sqJ9xoUUmRk=;
        b=kWO1l5aO7XjfO8nkO77g3i73vft1ytBoBmN6TlIm+N9MtyEmO5ffABcwWYkclcfYwp
         VdXeEUSLRojsSS0I+T4dK5sxPIZSnj+7lCEJ+I/fLXh9+PSabakukq2juI9ECJ+Cz/NM
         VEcxtpuyAurYYAUPQhtogievLN881nxAM95rxYB/O9aiOHRInxqUoOc498Mu6vI3Y4WV
         dqNlclniEjRSSwZV4pbn/MskJaiEmTnne5VA7Y78J3rANxPWn/IOT1OZaWt/ARXT00a/
         BDLHnehmEzGaVWM3LbEKUE4pr92TrMMiGk+lnUZ6BbcNp7Xty5NAH/n1f+4DqcP/K3io
         nabw==
X-Forwarded-Encrypted: i=1; AJvYcCWfayz63j7VwpRZ6fx7XX2yuhHcbqzacb4UDUV2lt4pNeMHNmLMe0aK2xma0+tdOI5iPcvo8JwPCxQCCZYf1eZ33G4LFpnt
X-Gm-Message-State: AOJu0YwiEziUncsgHBK9CnpbIRSlbKcky7GhWVoIXd+vWNrBRjVnsG3Z
	o8TZ/LAiD6YK2lOWCMLsxTCYgcFCsXT6iFz/lKLE8jQglxlOGiyl
X-Google-Smtp-Source: AGHT+IGyH+awiohqFZVOo/M+q+GYIU9GI7dSgjs+HC39rVVtiBMvE+uhgx/i4LAb5SM5zf8adATy5g==
X-Received: by 2002:aa7:99cc:0:b0:6ea:df65:ff7d with SMTP id d2e1a72fcca58-6f49c21342amr349431b3a.10.1715104078951;
        Tue, 07 May 2024 10:47:58 -0700 (PDT)
Received: from john.. ([98.97.42.227])
        by smtp.gmail.com with ESMTPSA id u34-20020a631422000000b00600d20da76esm9958611pgl.60.2024.05.07.10.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:47:58 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dhowells@redhat.com,
	kuba@kernel.org
Subject: [PATCH stable, 6.1 0/2] Fix for sockmap causing data stalls 
Date: Tue,  7 May 2024 10:47:55 -0700
Message-Id: <20240507174757.260478-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The attached two patches fix an issue with running BPF sockmap on TCP
sockets where applications error out due to sender doing a send for
each scatter gather element in the msg. The other 6.x stable and
longterm kernels have this fix so we don't see it there and the issue
was introduced in 6.1 by converting to the read_skb() interface. The
5.15 stable kernels use the read_sock() interface which doesn't have
this issue.

We missed adding the fixes tag to the original series because the work
was a code improvement and wasn't originally identified as a bugfix.

The first patch applies cleanly, the second patch does not because
it touches smc, espintcp, and siw which do not apply because that
code does not use sendmsg() yet on 6.1. I remove those chunks of the
patch because they don't apply here.

I added a Fixes tag to the patches to point at the patch introducing
the issue. Originally I sent something similar to this as a single
patch where I incorrectly merged the two patches. Greg asked me to
do this as two patches. Thanks.

David Howells (2):
  tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around
    tcp_sendmsg
  tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage

 net/ipv4/tcp_bpf.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.33.0


