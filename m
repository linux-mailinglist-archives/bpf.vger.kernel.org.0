Return-Path: <bpf+bounces-53258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BF9A4F231
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3A23AA5DD
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 00:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71664A1D;
	Wed,  5 Mar 2025 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9i+gTZm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55BB195
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133548; cv=none; b=SDAD+Ym0dbK8IpQk9ELpdtah8k0EJjf82U/pH5PK3d1pmEua9Xq7FgfJbO2LFu5Y5H/AZ1agDsLLbhCXVmM0sEY1zd9gUiDQBrsIGixqpUu4YBu0O9sMklclwPqqaMkjp6pksN7TctTcWMBsCBI5E3wRmvZ7gr//f/KQxeWpqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133548; c=relaxed/simple;
	bh=URwkL+2QTz12ZZTgM7DmjDWymwcvvDq8p/h4x1faZ2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ksxiVon8q3y93KBng7Dow+3zNP3f5rScnSdF2Hw25FEfMcmIUkj1SerwObV1poep973uS3dUwVfzNNdzAmrK2CGEdkJ8VyOxr6ATD1vGLI4XyUMF52QdK2GI9yUA6xFLfBdbQgbeL92uNI1+ef4h+VED+Ch0nAQx44QZRdVonxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9i+gTZm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22349bb8605so120965045ad.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 16:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741133546; x=1741738346; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E2PqWrA/W4VaAQq0hPPOXYEjgfot8Af3UF8liT5GP60=;
        b=Y9i+gTZmJ99b3P7VSjVQcCpxtTSJp//69PhPTUkFMtF59xGDVnwmD+06MOtrWtFj7b
         imGCw4L8MnrC5fJenPuHgo2LT9awK8R58sWGvu+8kYag1kQuY4cpJS4iIXOLfA7irrk2
         n8zoa1FpbdI49IlDx+QNrRp76BdzqcdgyvDIZHrlm2rEE8fZn+va6m6QU0F2IPXDmU8D
         VIVipbb6C9+5gvqF2LTAPdkgnFRSZLHFJsO2fYcE0/FgllzubESqIi5Q02RwEZbop+N5
         ExVG3QsOL/FE46PyM9Wrjp6SB+GeoLe9mih6KhMtZDrPhE86a3tUvi2A3RxlPG4bd5oQ
         YBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133546; x=1741738346;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2PqWrA/W4VaAQq0hPPOXYEjgfot8Af3UF8liT5GP60=;
        b=SWF4pI+DFBWYM+wi1sHKnb+T7Z98dJDNfMzAQ1/Ur9gXuFNDnTjlhWVOiLA09HYcTI
         R4DG4s0+Z0Kq64mD6ZyP1Loe9KOLmUuajEeL9mVfOUeBqy2RKp9XYR/d62+jRUHYyepr
         ph3H8hTbFadV2c3mgYhNVYvu4IHR9l9OaCL4CkipygdIX+hZE+j8gtD4CORA2ojB/6yp
         r5CSrldHvdbGvGXIQv1/lr4ImBAR3EbYfrPFxaJYJcs3R+a3up+SQGd2Q4dq8t1XfNqV
         wAVs00M6cdk4IFM+3ioPZvXy0sdC0awyDUbN9sFWxy/R9SgJjAgnLPI83Ei/Xp7Ja8NY
         pMwA==
X-Forwarded-Encrypted: i=1; AJvYcCVSIsvZnFCHN4FEya5A775TuBXYZUMONTUNtzwQdI9139C6PMp6TkqKQq/Qukdk+uumxJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzxGjGRTQ7LKZyQjeEPQhGDKRBdg/tiDZyB9oNcSIBcD+C3DBT
	3ounrWLvlQ65koGABwyi8P9t+A3xWmG2b1lnuZqV548a634BSKrF
X-Gm-Gg: ASbGncvvMWGmLUE6rQaIc97ZGmzEWe+uT4xCanlMr91Z2O2SjKOtL+ZFEVQ5zCUcmm+
	sDH9MtGXKnKCTaICgfqggQ0uBcmF6H3WZuquD0uRErGL+kpuGohp0o9b4+eGZx7efGjCRLZqjie
	IbwJHfWS2UnJ0V3ODMOHVVdlPA/MrfJOi+SqL/u+zXoYjjhpZJHR4laQzefDeYNU/2bltUki0uf
	7UZ+7Lq+R4VY5r2bDM211CPpKShGD3b6dG15znZl+ryGWX9ROI/r2NhIu6gUpTSbyk4rlmuGSzX
	Nme8+w0hiqshwqbi0OjU3YB5AU9vTjcxCupLlcLAHA==
X-Google-Smtp-Source: AGHT+IGu+GJrwXuOXDX5T05q4rvBMgDOKmB1wrplaHC8JyNTptGD0kGNkpw6jf/P7MH0+b/1e03pPw==
X-Received: by 2002:a05:6a00:c95:b0:736:3bd3:1a64 with SMTP id d2e1a72fcca58-73682cd9709mr1367899b3a.24.1741133545820;
        Tue, 04 Mar 2025 16:12:25 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec5csm11973777b3a.144.2025.03.04.16.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:12:25 -0800 (PST)
Message-ID: <eadb0123e2e576effbf1c7b0eac6b1da9b107fd4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Fix dangling stdout seen
 by traffic monitor thread
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Date: Tue, 04 Mar 2025 16:12:20 -0800
In-Reply-To: <20250304163626.1362031-3-ameryhung@gmail.com>
References: <20250304163626.1362031-1-ameryhung@gmail.com>
	 <20250304163626.1362031-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-04 at 08:36 -0800, Amery Hung wrote:
> Traffic monitor thread may see dangling stdout as the main thread closes
> and reassigns stdout without protection. This happens when the main threa=
d
> finishes one subtest and moves to another one in the same netns_new()
> scope.
> The issue can be reproduced by running test_progs repeatedly with traffic
> monitor enabled:
>=20
> for ((i=3D1;i<=3D100;i++)); do
>    ./test_progs -a flow_dissector_skb* -m '*'
> done
>=20
> Fix it by first consolidating stdout assignment into stdio_restore().
> stdout will be restored to env.stdout_saved when a test ends or running
> in the crash handler and to test_state.stdout_saved otherwise.
> Then, protect use/close/reassignment of stdout with a lock. The locking
> in the main thread is always performed regradless of whether traffic
> monitor is running or not for simplicity. It won't have any side-effect.
> stdio_restore() is kept in the crash handler instead of making all print
> functions in the crash handler use env.stdout_saved to make it less
> error-prone.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

This patch fixes the error for me.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

>  tools/testing/selftests/bpf/test_progs.c | 59 ++++++++++++++++--------
>  1 file changed, 39 insertions(+), 20 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
> index ab0f2fed3c58..5b89f6ca5a0a 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -88,7 +88,11 @@ static void stdio_hijack(char **log_buf, size_t *log_c=
nt)
>  #endif
>  }
> =20
> -static void stdio_restore_cleanup(void)
> +static pthread_mutex_t stdout_lock =3D PTHREAD_MUTEX_INITIALIZER;
> +
> +static bool in_crash_handler(void);
> +
> +static void stdio_restore(void)
>  {
>  #ifdef __GLIBC__
>  	if (verbose() && env.worker_id =3D=3D -1) {
> @@ -98,34 +102,34 @@ static void stdio_restore_cleanup(void)
> =20
>  	fflush(stdout);
> =20
> -	if (env.subtest_state) {
> +	pthread_mutex_lock(&stdout_lock);
> +
> +	if (!env.subtest_state || in_crash_handler()) {
> +		if (stdout =3D=3D env.stdout_saved)
> +			goto out;
> +
> +		fclose(env.test_state->stdout_saved);
> +		env.test_state->stdout_saved =3D NULL;
> +		stdout =3D env.stdout_saved;
> +		stderr =3D env.stderr_saved;
> +	} else {
>  		fclose(env.subtest_state->stdout_saved);
>  		env.subtest_state->stdout_saved =3D NULL;
>  		stdout =3D env.test_state->stdout_saved;
>  		stderr =3D env.test_state->stdout_saved;
> -	} else {
> -		fclose(env.test_state->stdout_saved);
> -		env.test_state->stdout_saved =3D NULL;
>  	}
> +out:
> +	pthread_mutex_unlock(&stdout_lock);
>  #endif
>  }

stdio_restore_cleanup() did not reset stderr/stdout when
env.subtest_state was NULL, but this difference does not seem to
matter, stdio_restore_cleanup() was called from:
- test__start_subtest(), where stdio_hijack_init() would override
  stderr/stdout anyways.
- run_one_test(), where it is followed by call to stdio_restore().

I think this change is Ok.

[...]

> @@ -1276,6 +1281,18 @@ void crash_handler(int signum)
>  	backtrace_symbols_fd(bt, sz, STDERR_FILENO);
>  }
> =20
> +static bool in_crash_handler(void)
> +{
> +	struct sigaction sigact;
> +
> +	/* sa_handler will be cleared if invoked since crash_handler is
> +	 * registered with SA_RESETHAND
> +	 */
> +	sigaction(SIGSEGV, NULL, &sigact);
> +
> +	return sigact.sa_handler !=3D crash_handler;
> +}
> +

The patch would be simpler w/o this function. I double checked
functions called from crash_handler() and two 'fprintf(stderr, ...)'
there are the only places where stderr/stdout is used instead of
*_saved versions. It is already a prevalent pattern to do
'fprintf(env.stderr_saved, ...)' in this file.
Or pass a flag as in v3?

>  void hexdump(const char *prefix, const void *buf, size_t len)
>  {
>  	for (int i =3D 0; i < len; i++) {
> @@ -1957,6 +1974,8 @@ int main(int argc, char **argv)

[...]


