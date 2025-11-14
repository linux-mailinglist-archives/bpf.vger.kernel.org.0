Return-Path: <bpf+bounces-74566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D65C5F525
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5BA14E1C1C
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B3D30148B;
	Fri, 14 Nov 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSEbpf8h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600DC3009E6
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154743; cv=none; b=D8GvQhx67WR2ahLIOApPMk0uJKloL1tTa2sUaYgqnbF8q6rkThtbFGKPmLbAtJCKVDj1izlLJHrVzR7+1ejWQiavPw+Vp3jWl0/2TAEyGW2dyHIQ5/9ppdhZ5b8mDF0rmM/Sd6nBwa/eCGSv7YUj/9ydE06C1uqrFShNILCVHvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154743; c=relaxed/simple;
	bh=HIzL03rZZAUOTidXvfl1eRZAhFxza8AIANmJTh/lei4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GOsa6AbtQ+hZnqeTOrLGcY4wyNM0XzctNDxmREGsqDxPvqdNixJXdC+nXOHqytGqSWCV1hJFvT0JJYwX9Xoe61MhfnXHR9hXHVpMX3uM9Pg/aWGijr2corBeI4n9ZdIEVjdWnfRYt/o5ydQsJFRoH2P5QhoOs3J8uypyOYZ00kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSEbpf8h; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3437b43eec4so4173134a91.3
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 13:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763154742; x=1763759542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RhOb5eINxbYUfto3PJNXs+AkFfHyV62oHB08Gr6skkc=;
        b=XSEbpf8hiDCU+M3zEWxxkCxOhpAgSMlCxPiTiFSALuYyeLxgkNn+5eQFKxSEWGeCmV
         wGNk1SvYlUtdDAMAXblBw4hqz9pYuh49At3oSrzjeVNzMT+V8gt7/HDD9rycNCkUE4k9
         7M0RnphxgBT8pxTi7MY+QQ6SzxKk8YObM/adptGAfQ2cGySd2rEBPOvaY+zthhwkTwps
         AVsbbt8NQKAyjpBNhdDTKwrKJAnkJYYjGY1y5cyHXsyRsgep7+g/96W3qy4LHkeTe3s/
         BMbwm+HU9eXkVhbkRFBvGpBNdpfhsXBsXsxKvBzlyFC0fYaAXPRZx+EEYZmBP9XzlWhd
         fujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763154742; x=1763759542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhOb5eINxbYUfto3PJNXs+AkFfHyV62oHB08Gr6skkc=;
        b=c9Xl+cMrYiX/WwV36GBOnU7S4QuI92hE0ZNG7haHaMIH57D83xtL5DRb83cUztgf31
         abKjUb7i9LQkXU8lIRuyCO55s5oXGatchF1Ja8UjgZwwoMGNVCu/akdxA8WqC+PX068R
         B5v+n/A9M6+Jj1MLYpjz0ZTYHqMa2jgicgaEzA/9rn2k4lC0CmqUpb49MJuudirYYkOQ
         FdkE+QMLP/ZTklacf3353W6OhQRAAUYnVwL3twa1VgzPYOdapfyAOs5EhEwX+R5mBH8n
         KE73REfz7xsKKpcCxfSJa5QYvNyAIujPxEAFMhM0CCkT2e5pv6TC25gP4R83TfHmrpi2
         09LA==
X-Forwarded-Encrypted: i=1; AJvYcCUuFH5qeeJVWvdhEP81AXair/0QP3gXv3tFQYcUBQ4mF/uqDcrkoZhBa0M31bX2ayZB8fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSW5a+mzoTjG1Gg+6tmXBgHXdX/pvoy4sVgSSW06+iINPlBfq
	il8b9PjOxFDlaSUAlYRb9GicYCyCCWDIbJfj49WGnUTUwlYjY8hAi8XtpvSU4zFRVOvSIW+8J03
	4mSf7IJ3IHf+q5Q==
X-Google-Smtp-Source: AGHT+IH2SZTUOOQ6vWGJjYH872jf1jo5IMY/q9mTGV8DDNjT8yCxuYhoSzRXceAHLxAryX5ra3tVnVDiQoEALw==
X-Received: from pjtp2.prod.google.com ([2002:a17:90a:c002:b0:33b:51fe:1a75])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b86:b0:33e:30b2:d20 with SMTP id 98e67ed59e1d1-343fa79011cmr5107680a91.33.1763154741676;
 Fri, 14 Nov 2025 13:12:21 -0800 (PST)
Date: Fri, 14 Nov 2025 13:11:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114211146.292068-1-joshwash@google.com>
Subject: [PATCH net-next 0/4] gve: Implement XDP HW RX Timestamping support
 for DQ
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, Kevin Yang <yyd@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

This patch series adds support for bpf_xdp_metadata_rx_timestamp from an
XDP program loaded into the driver on its own or bound to an XSK. This
is only supported for DQ.

Tim Hostetler (4):
  gve: Move ptp_schedule_worker to gve_init_clock
  gve: Wrap struct xdp_buff
  gve: Prepare bpf_xdp_metadata_rx_timestamp support
  gve: Add Rx HWTS metadata to AF_XDP ZC mode

-- 
2.51.2.1041.gc1ab5b90ca-goog


