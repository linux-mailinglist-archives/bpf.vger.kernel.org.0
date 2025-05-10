Return-Path: <bpf+bounces-57979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B46AB2422
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B4517FCF8
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A11122F749;
	Sat, 10 May 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b="c2OXIrlL";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="v/nqY/R2"
X-Original-To: bpf@vger.kernel.org
Received: from e240-12.smtp-out.eu-north-1.amazonses.com (e240-12.smtp-out.eu-north-1.amazonses.com [23.251.240.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296716DC28;
	Sat, 10 May 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746886820; cv=none; b=hon3pnv53OkAUiGqScKr3eliVNAJ170BKrcBkEawOKQKL0hDeVm+7cJzHcU+cgLhvWeokewzNqu1zNT9LZsal0qJ+cSxKLuAnpBUki7TfyO0NfKm0yW05cpXAFbxdA+4h4yqDf/lbNk63VpiZk31KAJW4j0y1RUmzLquDXWDb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746886820; c=relaxed/simple;
	bh=W4dfzqv6AVpFXXhlz8eW7YmlgYyARION7sDNz5oerQk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WiTaStn1lQVuFy1gD2M0hgKde+yczSy/K3BNTMDYK2kHSG2V924XHTFeubyWpl5NXYtd2u7Ls5i/v44M/gSba/L8fCFAVtZkUOjtn097hK9cEQjAZDB2pDljWKjw+HzWZe+aXIh0gQPg7hUELPnPveLFn2ZRxdZXRKKh96A7Gjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b=c2OXIrlL; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=v/nqY/R2; arc=none smtp.client-ip=23.251.240.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=iuunfi4kzpbzwuqjzrd5q2mr652n55fx; d=goosey.org; t=1746886815;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
	bh=W4dfzqv6AVpFXXhlz8eW7YmlgYyARION7sDNz5oerQk=;
	b=c2OXIrlLwAJOng4V1Sa0bbVU9v1ianQTAJuiuD8nwk+6DCwSd7MtsqQIhmK9oViC
	9g9zjc2Okvp2ROZzz9UYU5uU0731qvHAoQtfkDxZ83MIes7C0OgWDcYt5Z+KApJzyNf
	axI/UNMHUsQBDVjtDGW1CIzmwB5cO+RO1oNefrtnsP8AKjzV57MDuMmn5bQax6mS0gT
	PdKGNDNCME/nczxdjCWM9OfdAOhNRVpSPI+mWbkcf0RZrNynl62ZdM3Z2joXBCy0f2f
	s3wByJtU1QMIQUEUTFtnRV8epa5iIAKwnCfyHjXXiolSh8j+1ODEexq0lzjcw6E5xqy
	mOIiTYjuFQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bw45wyq3hkghdoq32obql4uyexcghmc7; d=amazonses.com; t=1746886815;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type:Feedback-ID;
	bh=W4dfzqv6AVpFXXhlz8eW7YmlgYyARION7sDNz5oerQk=;
	b=v/nqY/R2iIjqjOYaF0vvtF+XJ6zP5J6me1OgdyuaOnXcDYEUfbmIpIMoIkUNNxWQ
	17Py3RKKMzOhMTTSbmIN3leVCUa+aEj5I/6LZ3AlNTHdBklWFzO+0HFJUe8jHudErqE
	aIqZ6sj3SaCe+4etg6lb9GehWJia1r/83qHAL7lw=
X-Forwarded-Encrypted: i=1; AJvYcCVer5Zk7ze7BbX1oPKStl38QfAmoKeQ8lBD0+zXGupB87ww808naV37975aeetiFivf6eg=@vger.kernel.org, AJvYcCWiWHWYK4XBhQTtYvM9DVDdi43miWP1Ucs0b+bvxXk1NAAtSQaYCLHTeWAGepTrnReyyIMiOUBVQv0DHuub@vger.kernel.org, AJvYcCXs2mlnAdjJrMqkRDVhVdv7h4dUU50U/wjiROStb8IQ6zKNORMcj3QQHuDfMKWi2NvX0qB2BQPl@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlS60YSiZ1kdvt42hKu5F8aM7uTZLH0y8p/vIPUEbPq5ykqs6
	1MnkbZAreMk6fNUJSwFP9A0mKZkUWADPCzyiiJ5ChrSORyYaONYKREvwiKNMqkV1wCrs8z2sQgP
	Pk94VjGp3UEyyIXpDUAjgkBhORBU=
X-Google-Smtp-Source: AGHT+IEy1OhILB1EvJo8A2caKqKiZ4iDfLwWXOLB5rdnMuna182Us5RDEBBhnrgxuQpshc4hhSi0IhZUBiILhsmkMtQ=
X-Received: by 2002:a17:902:ce11:b0:22e:50f2:1450 with SMTP id
 d9443c01a7336-22fc93e1f73mr112769095ad.22.1746886812858; Sat, 10 May 2025
 07:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ozgur Kara <ozgur@goosey.org>
Date: Sat, 10 May 2025 14:20:15 +0000
X-Gmail-Original-Message-ID: <CADvZ6EoAPepV0Ky06y-njZW2zksnsQgVtb4i9Dw1NkCtpJFqXg@mail.gmail.com>
X-Gm-Features: AX0GCFuIqzkyK3zlz8iU0VtbAwxDbKOBQrNGpXev9BrFS-s78ADtV9Ig-H-a7vc
Message-ID: <01100196ba916f60-f2642e95-026a-4ba3-bd32-f871d781c2d6-000000@eu-north-1.amazonses.com>
Subject: [PATCH] net: fix unix socket bpf implementation: ensure reliable
 wake-up signaling
To: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Feedback-ID: ::1.eu-north-1.jZlAFvO9+f8tc21Z4t7ANdAU3Nw/ALd5VHiFFAqIVOg=:AmazonSES
X-SES-Outgoing: 2025.05.10-23.251.240.12

From: Ozgur Kara <ozgur@goosey.org>

This patch addresses a race condition in the unix socket bpf
implementation where wake-up signals could be missed. specifically,
after releasing mutex (`mutex_unlock(&u->iolock)`) and before
acquiring it again (`mutex_lock(&u->iolock)`) another thread can
insert data and send a wake-up signal. if this signal occurs before
`wait_woken()` is called, it may be lost and cause the thread to
remain unnecessarily blocked.

to fix this patch introduces a safer wait mechanism using
`prepare_to_wait()` and `finish_wait()` which ensures that the wakeup
signal is not missed. this prevents unnecessary blocking and reduces
the risk of potential deadlocks in high-load or multi-processor
environments.

such race conditions can lead to performance degradation or, in rare
cases, deadlocks, especially under heavy load or on multi-cpu systems
where the problem may be difficult to reproduce.

also there was a space in the last line so i added a checkpatch correction :)

Signed-off-by: Ozgur Kara <ozgur@goosey.org>
--
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index e0d30d6d22ac..04f2b38803d2 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -26,14 +26,29 @@ static int unix_msg_wait_data(struct sock *sk,
struct sk_psock *psock,
        if (!timeo)
                return ret;

+       /* wait queue is waited */
        add_wait_queue(sk_sleep(sk), &wait);
        sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
+
+       /* control while locked */
        if (!unix_sk_has_data(sk, psock)) {
+               set_current_state(TASK_INTERRUPTIBLE);
                mutex_unlock(&u->iolock);
-               wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
+
+               if (!schedule_timeout(timeo))
+                       ret = 0; /* timeout set */
+               else
+                       ret = signal_pending(current) ? -ERESTARTSYS : 1;
+
                mutex_lock(&u->iolock);
-               ret = unix_sk_has_data(sk, psock);
+
+               if (ret > 0)
+                       ret = unix_sk_has_data(sk, psock);
+       } else {
+               ret = 1; /* return data */
        }
+
+       __set_current_state(TASK_RUNNING);
        sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
        remove_wait_queue(sk_sleep(sk), &wait);
        return ret;
@@ -198,5 +213,4 @@ void __init unix_bpf_build_proto(void)
 {
        unix_dgram_bpf_rebuild_protos(&unix_dgram_bpf_prot, &unix_dgram_proto);
        unix_stream_bpf_rebuild_protos(&unix_stream_bpf_prot,
&unix_stream_proto);
-
 }
--

