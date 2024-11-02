Return-Path: <bpf+bounces-43798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD959B9B8C
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 01:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9134D1C20B8E
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 00:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946228F5A;
	Sat,  2 Nov 2024 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoXr1cZM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F36AB8
	for <bpf@vger.kernel.org>; Sat,  2 Nov 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506918; cv=none; b=SAGZLFsOo64q4zwiX2/pol8uXngKRwVFREvoYEkw8qd8p+zO81M6HZvop0eCO4ttWu+d7giVRaxHmCMiaWgHGhxOZ350jVuO7OLDjQAj7KmBQeZmkTBZlgT5TCoL2Sdo7Hw00OdcUtZElDGXLdPre6/D0OibgA0g6ya1mYL3LnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506918; c=relaxed/simple;
	bh=0jvlRVzwsnbW+cXArFPqa4v6DP9YQmac6ZXATt+jxMM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAZiB/jeuWviMuzyLBd9Wh309Vx9s0zI5FtXbAsAqORK+tk/oTfj1jpZV2XH5B/r7lo17PXd5c+eis6IAFHTPkU/uAh8iL82TkT1OSa8jkF2+PnF16PnVDiwSyUfzTBso8m0lazhaCcTxOV2R4jM1+W58rA0IggvFrjUX4kHk3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoXr1cZM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720c286bcd6so1807943b3a.3
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730506916; x=1731111716; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ENq7/S934zwBdzzjL+zw5byrwa909GTLHJMtynMQi2o=;
        b=XoXr1cZMqT1Uqh6htQ1thrEjiUFiIYME6IDGt6h8/dieCkUy6cEgnntuZtroAs+xYd
         KLlEcDWMTljgS/ZahFOdjfRxIOqMX/d6EmundrcuF7TGfo9jwMeNhhwnxAUuKEPQOQc4
         FBAq3XDcyyphMWoEb5G4gAHy85yS8o/2PrGVE3H+ooTu77I0Da/fIBCYQKTTIJuhc0v9
         RYe5jLata69pPyCQ5IO9esEld4d1/pXKZhCmtqjhDjJo7k3ohSxcgDHNJdLySEQitKKs
         790pBXXAq5qHWroxrbQSrHBW427ZuI2X+Szs9k8itq6gCUweoaaCTG5gZAAnFjBQb3xd
         GAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506916; x=1731111716;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ENq7/S934zwBdzzjL+zw5byrwa909GTLHJMtynMQi2o=;
        b=G2t/s5hXIPUDxvnD5ZFdQ4MFHOIMKBM1RZZF7SRUcNqsYKkM1HxsNYjciSv9j2Lc8k
         7dq76qfVH7CsBVShwdGDF3RFYmx4aZ9SbOc3shWOeWn1JQmVj2nd2ZfmLyjq7Q2J0fwY
         5B85GW1mSaBnoGcwUowU/UcyOl/aOqurXldr48xBBJub2EW4dMMyiGIv7k+/KUvWVoh5
         e+7JmMamN4hqnMw8KMJdbPTCWDIkFgZkt4a9bdjkEeu8tJgX3s+2oig8v1WPqSDFHYw1
         zkXjfaQ2ewg5dPRtK4y6ukfroyxmLfyjuctbvVMkbc2FrhmJ2t4OG5wq5a9afrCxrFAA
         4ebg==
X-Forwarded-Encrypted: i=1; AJvYcCUkAc3BAn1lSnyyZnZXVKW4ZBHVDH4RQfE9yJL2FYPSst7En07Zes1VlMD/Shz8rP+utwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFt9YhTDGevFc5gCZyOTSyBW+OSPxgo/KWN4Sy5BtZ5RRhUfkQ
	V00Rgt1k9MMTzp0LuiVvYK9ipGnXxhJn8vfFeg/XOb1aui+tU9Uz
X-Google-Smtp-Source: AGHT+IGbNZgwBm2shQlI+1SuzD7vnPq4dpnHJXltujRxLaIrlBB/AF6isA49AXR8L8jgmpfHoooDGg==
X-Received: by 2002:a05:6a00:844:b0:71e:792b:4517 with SMTP id d2e1a72fcca58-72062f8a78amr11814586b3a.14.1730506914921;
        Fri, 01 Nov 2024 17:21:54 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc31ef5dsm3255943b3a.220.2024.11.01.17.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:21:54 -0700 (PDT)
Message-ID: <c3f7ee7790c6f53a572ff2857433f534f4972189.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] Handle possible NULL trusted raw_tp
 arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
	 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Song Liu
	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt
	 <rostedt@goodmis.org>, Jiri Olsa <olsajiri@gmail.com>, Juri Lelli
	 <juri.lelli@redhat.com>, kernel-team@fb.com
Date: Fri, 01 Nov 2024 17:21:49 -0700
In-Reply-To: <CAP01T75OUeE8E-Lw9df84dm8ag2YmHW619f1DmPSVZ5_O89+Bg@mail.gmail.com>
References: <20241101000017.3424165-1-memxor@gmail.com>
	 <CAP01T75OUeE8E-Lw9df84dm8ag2YmHW619f1DmPSVZ5_O89+Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-01 at 14:18 +0100, Kumar Kartikeya Dwivedi wrote:

[...]

> I see that all selftests except one passed. The one that didn't
> appears to have been cancelled after running for an hour, and stalled
> after select_reuseport:OK.
> Looking at the LLVM 18
> (https://github.com/kernel-patches/bpf/actions/runs/11621768944/job/32366=
412581?pr=3D7999)
> run instead of LLVM 17
> (https://github.com/kernel-patches/bpf/actions/runs/11621768944/job/32366=
400714?pr=3D7999,
> which failed), it seems the next test send_signal_tracepoint.
>=20
> Is this known to be flaky? I'm guessing not and it is probably caused
> by my patch, but just want to confirm before I begin debugging.

I suspect this is a test send_signal.
It started to hang for me yesterday w/o any apparent reason (on master bran=
ch).
I added workaround to avoid stalls, but this does not address the
issue with the test. Workaround follows.

---

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/t=
esting/selftests/bpf/prog_tests/send_signal.c
index ee5a221b4103..4af127945417 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -18,6 +18,38 @@ static void sigusr1_siginfo_handler(int s, siginfo_t *i,=
 void *v)
=20
 static char log_buf[64 * 1024];
=20
+static ssize_t read_with_timeout(int fd, void *buf, size_t count)
+{
+	struct timeval tv =3D { 1, 0 };
+	fd_set fds;
+	int err;
+
+	FD_ZERO(&fds);
+	FD_SET(fd, &fds);
+	err =3D select(fd + 1, &fds, NULL, NULL, &tv);
+	if (!ASSERT_GE(err, 0, "read select"))
+		return err;
+	if (FD_ISSET(fd, &fds))
+		return read(fd, buf, count);
+	return -EAGAIN;
+}
+
+static ssize_t write_with_timeout(int fd, void *buf, size_t count)
+{
+	struct timeval tv =3D { 1, 0 };
+	fd_set fds;
+	int err;
+
+	FD_ZERO(&fds);
+	FD_SET(fd, &fds);
+	err =3D select(fd + 1, NULL, &fds, NULL, &tv);
+	if (!ASSERT_GE(err, 0, "write select"))
+		return err;
+	if (FD_ISSET(fd, &fds))
+		return write(fd, buf, count);
+	return -EAGAIN;
+}
+
 static void test_send_signal_common(struct perf_event_attr *attr,
 				    bool signal_thread, bool remote)
 {
@@ -75,10 +107,10 @@ static void test_send_signal_common(struct perf_event_=
attr *attr,
 		}
=20
 		/* notify parent signal handler is installed */
-		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
+		ASSERT_EQ(write_with_timeout(pipe_c2p[1], buf, 1), 1, "pipe_write");
=20
 		/* make sure parent enabled bpf program to send_signal */
-		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
+		ASSERT_EQ(read_with_timeout(pipe_p2c[0], buf, 1), 1, "pipe_read");
=20
 		/* wait a little for signal handler */
 		for (int i =3D 0; i < 1000000000 && !sigusr1_received; i++) {
@@ -94,10 +126,10 @@ static void test_send_signal_common(struct perf_event_=
attr *attr,
 		buf[0] =3D sigusr1_received;
=20
 		ASSERT_EQ(sigusr1_received, 8, "sigusr1_received");
-		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
+		ASSERT_EQ(write_with_timeout(pipe_c2p[1], buf, 1), 1, "pipe_write");
=20
 		/* wait for parent notification and exit */
-		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
+		ASSERT_EQ(read_with_timeout(pipe_p2c[0], buf, 1), 1, "pipe_read");
=20
 		/* restore the old priority */
 		if (!remote)
@@ -158,7 +190,7 @@ static void test_send_signal_common(struct perf_event_a=
ttr *attr,
 	}
=20
 	/* wait until child signal handler installed */
-	ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");
+	ASSERT_EQ(read_with_timeout(pipe_c2p[0], buf, 1), 1, "pipe_read");
=20
 	/* trigger the bpf send_signal */
 	skel->bss->signal_thread =3D signal_thread;
@@ -172,7 +204,7 @@ static void test_send_signal_common(struct perf_event_a=
ttr *attr,
 	}
=20
 	/* notify child that bpf program can send_signal now */
-	ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
+	ASSERT_EQ(write_with_timeout(pipe_p2c[1], buf, 1), 1, "pipe_write");
=20
 	/* For the remote test, the BPF program is triggered from this
 	 * process but the other process/thread is signaled.
@@ -188,7 +220,7 @@ static void test_send_signal_common(struct perf_event_a=
ttr *attr,
 	}
=20
 	/* wait for result */
-	err =3D read(pipe_c2p[0], buf, 1);
+	err =3D read_with_timeout(pipe_c2p[0], buf, 1);
 	if (!ASSERT_GE(err, 0, "reading pipe"))
 		goto disable_pmu;
 	if (!ASSERT_GT(err, 0, "reading pipe error: size 0")) {
@@ -199,7 +231,7 @@ static void test_send_signal_common(struct perf_event_a=
ttr *attr,
 	ASSERT_EQ(buf[0], 8, "incorrect result");
=20
 	/* notify child safe to exit */
-	ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
+	ASSERT_EQ(write_with_timeout(pipe_p2c[1], buf, 1), 1, "pipe_write");
=20
 disable_pmu:
 	close(pmu_fd);


