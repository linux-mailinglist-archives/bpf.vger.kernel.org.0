Return-Path: <bpf+bounces-773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8439A7068E2
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 15:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400F928125E
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EAE156FC;
	Wed, 17 May 2023 13:06:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885E18B0D
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 13:06:01 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492C21A2;
	Wed, 17 May 2023 06:05:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6439e6f5a33so514338b3a.2;
        Wed, 17 May 2023 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684328759; x=1686920759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtyFrGfqKkakJXFw6p+ddnB6eN6diQD5RAmdRXKE4A4=;
        b=DNj9p/rNZpttjQvvi7Jm4nTonkfssVDW8efMg1RxiXGPoGysbBJrF+4LDsaDvxEeqD
         6FbvWZOToK3LZ1Q0i9SZ5SyANE0TtOaGzkn7h765fCrEykwM6q5JoMLReBb3uywyjjoP
         yPAKc8r0lFrwU3HM7kP/mPbOHTwVd7Popqbgi7R3kdnJdkv3ioGzS2IW1i6nJYkkOtIa
         Pt7JA2k5t4i2BQ3zbf0lIe83A4t25b6Pis/p2iRMQRozkHxSlglSqROG2OiCw0cRZn9Z
         8Tw3x+vlMsHGV1y0Ockl9Ei7zUwN+MhRXxKynBLyVAcMRtRM7UgWhTCUQ/TAUAIeHYHn
         rPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684328759; x=1686920759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtyFrGfqKkakJXFw6p+ddnB6eN6diQD5RAmdRXKE4A4=;
        b=h41XeAdhUKEWZnk+Uw6NTVhs8i/MbL7rRqJ2mbBjHPgtIgCFUp9Tv82MNmrHNiOSN/
         qY3J6LCoVSoLpbYT8eu0/77CybyGTiIs6WvE6s/kckq/2F4BwvrV+qR52qsNPEtL4dx5
         D/x4scRkLBYEATl3ZYjVKvCiVYmhmQ3CZDddfj9W9V4OV2cJshuwHLbTGbVtHHe97Fid
         Hh5nzv0aCRERV3szUzE5rB40+6opmfYwxKPA/NNQgtpsmMl0tCWjUwJwb1N90iFVH20t
         x30B8mUUYQ7RKOyFjH4FWFshYChY7uwmGfIHWHDRtU09DXvJw5X5py4BYblnwgf/H2oP
         /kDQ==
X-Gm-Message-State: AC+VfDxdP5W1oRtPXZ6WYgx6Nc4GfZVOCUSZ44xXbOLEVO/M6WjINRX/
	rudKf9W2ukMY8jJJPNcWfs72gRp1afD2mA==
X-Google-Smtp-Source: ACHHUZ7IOyaW4XbBAbuRkSoKVhCmX8H25L3dq2CXvCQ9FdgToR71UHsqrgXFzLPSTpd2DDDh9MmPgA==
X-Received: by 2002:a05:6a00:1996:b0:63d:47ab:65ed with SMTP id d22-20020a056a00199600b0063d47ab65edmr984178pfl.7.1684328758586;
        Wed, 17 May 2023 06:05:58 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id x20-20020aa793b4000000b0063d2bb0d107sm15229351pff.64.2023.05.17.06.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:05:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 977BC104714; Wed, 17 May 2023 20:05:54 +0700 (WIB)
Date: Wed, 17 May 2023 20:05:54 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v11 11/11] Documentation: tracing/probes: Add fprobe
 event tracing document
Message-ID: <ZGTRMsLQ3QqvCGew@debian.me>
References: <168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com>
 <168432122914.1351929.944185321099763072.stgit@mhiramat.roam.corp.google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ky6EilGNz1vHfqqH"
Content-Disposition: inline
In-Reply-To: <168432122914.1351929.944185321099763072.stgit@mhiramat.roam.corp.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--ky6EilGNz1vHfqqH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 08:00:29PM +0900, Masami Hiramatsu (Google) wrote:
> +As same as other dynamic events, fprobe events and tracepoint probe
> +events are defined via `dynamic_events` interface file on tracefs.

Backquotes are rendered as italics instead. If you mean keyword/identifier,
inline it with double backquotes (like ``foo``). Or you can skip formatting
it instead (to be consistent with other keywords).

> +For the details of TYPE, see :file:`Documentation/trace/kprobetrace.rst`.

Did you mean using :doc: directive instead?

---- >8 ----
diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fpro=
betrace.rst
index eca64ad7216a1c..0cf8ed84bd6651 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -64,7 +64,7 @@ Synopsis of fprobe-events
   (\*4) this is useful for fetching a field of data structures.
   (\*5) "u" means user-space dereference.
=20
-For the details of TYPE, see :file:`Documentation/trace/kprobetrace.rst`.
+For the details of TYPE, see :doc:`kprobetrace`.
=20
 BTF arguments
 -------------

On the other hand, you can also directly link to intended doc section:

---- >8 ----
diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fpro=
betrace.rst
index eca64ad7216a1c..83892c7512726c 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -64,7 +64,7 @@ Synopsis of fprobe-events
   (\*4) this is useful for fetching a field of data structures.
   (\*5) "u" means user-space dereference.
=20
-For the details of TYPE, see :file:`Documentation/trace/kprobetrace.rst`.
+For the details of TYPE, see :ref:`kprobetrace documentation <kprobetrace_=
types>`.
=20
 BTF arguments
 -------------
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kpro=
betrace.rst
index 651f9ab53f3ee9..8a2dfee3814544 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -66,6 +66,8 @@ Synopsis of kprobe_events
   (\*3) this is useful for fetching a field of data structures.
   (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
=20
+.. _kprobetrace_types:
+
 Types
 -----
 Several types are supported for fetchargs. Kprobe tracer will access memory

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ky6EilGNz1vHfqqH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGTRLwAKCRD2uYlJVVFO
owQ8AQC1x1fvlyM1knwxxY3/PxegbkGTRhiar2QW5YX+U8h14QEA+N0PVJKuJDXx
S/hl51lE9DLUn17lZ4MQhaMmp222kQA=
=WlLN
-----END PGP SIGNATURE-----

--ky6EilGNz1vHfqqH--

