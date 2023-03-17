Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2168F6BEC62
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 16:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCQPG7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 11:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjCQPG6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 11:06:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5163A4FF
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 08:06:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y15so6866893lfa.7
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 08:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679065548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7gFkD7rBzK+vfovkGmVg89qzKi3xPf5o3AHqPR9GHKI=;
        b=YA2vMaE/wt3fbQY56ubWxY3+CQscqu8a3bLZHWn0Ec9H74i932W06GZQuw3SNHw/NF
         5evdrwixcEEf5nbNyzCEik/ef/s+UvUBOBdZt0dQ6WPUiu4a3YGKq6eA+eXGsI6yNcF1
         y8wc0QqU/5GxKixb9r9Af2QRke9SsiionW+wCJ/zgyxcJVWVSEgPL3Eje+91/ojbZ7Zg
         bD4vDB5SPxMr2b+tS7c3kh0bkEaQ5/sKAfmh66J06uJdohOO58qfRisw4la2SlIuuTyl
         mNMHVR1J07B99EbsIRwTrfSd2MwEmxADIZizn8y/4sHdQiuMSxjZgJ6XjjrV4qpodMub
         kYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679065548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gFkD7rBzK+vfovkGmVg89qzKi3xPf5o3AHqPR9GHKI=;
        b=aNu2JRQqsr/z1r3yZk4pyU6S7tPkIjCsSoNuPr4u1kPWu8phtC1QY0DsqQy2xmLQGd
         y9SOROoEi+iZAWUxSXweKXrAFoNDF2DqubYpHwvisV3mMfwPoUgC4uF4VcM5HvMTSlaF
         Cui4EJ8rbheTOb+gkKhQ+lGYkOr60P3JsqDeUJGM2VQ37EBlK8dcy1Pi/IrSpWWVTUri
         80nY7l0vXovabL6BGPeh85wEgUkq8R3UBjLvWAAQIjHuRaO9xYlACAI4LvoKjwQ1IG8j
         1c70B6qKsg+NHdqmGNUECKuvwHTPq+VrDa6XYWdQFXpTBtzlI7U0i4kQr5JzG1kir9YB
         9RxA==
X-Gm-Message-State: AO0yUKVPWoud2pdmSo4pi8do+xXvXFIeKZpqtMKWfIY2OcOsL2phf7MJ
        TuagE7l3G0mqAwM3BhwOY6g=
X-Google-Smtp-Source: AK7set/SVeribVne1XvgrEw5us0eUwZeeSt3b1JGBQBraoy5O1kamprgRPINFaXVi1LhLn5QcZ+82w==
X-Received: by 2002:ac2:55ae:0:b0:4cb:e53:d54b with SMTP id y14-20020ac255ae000000b004cb0e53d54bmr4020646lfg.25.1679065547612;
        Fri, 17 Mar 2023 08:05:47 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y17-20020ac24471000000b004aac23e0dd6sm423058lfl.29.2023.03.17.08.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:05:46 -0700 (PDT)
Message-ID: <dacb74f46aef078e101d631ce95f03fddf17e284.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc:     kernel-team@meta.com
Date:   Fri, 17 Mar 2023 17:05:45 +0200
In-Reply-To: <20230316183013.2882810-4-andrii@kernel.org>
References: <20230316183013.2882810-1-andrii@kernel.org>
         <20230316183013.2882810-4-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-03-16 at 11:30 -0700, Andrii Nakryiko wrote:
> Currently, if user-supplied log buffer to collect BPF verifier log turns
> out to be too small to contain full log, bpf() syscall return -ENOSPC,
> fails BPF program verification/load, but preserves first N-1 bytes of
> verifier log (where N is the size of user-supplied buffer).
>=20
> This is problematic in a bunch of common scenarios, especially when
> working with real-world BPF programs that tend to be pretty complex as
> far as verification goes and require big log buffers. Typically, it's
> when debugging tricky cases at log level 2 (verbose). Also, when BPF prog=
ram
> is successfully validated, log level 2 is the only way to actually see
> verifier state progression and all the important details.
>=20
> Even with log level 1, it's possible to get -ENOSPC even if the final
> verifier log fits in log buffer, if there is a code path that's deep
> enough to fill up entire log, even if normally it would be reset later
> on (there is a logic to chop off successfully validated portions of BPF
> verifier log).
>=20
> In short, it's not always possible to pre-size log buffer. Also, in
> practice, the end of the log most often is way more important than the
> beginning.
>=20
> This patch switches BPF verifier log behavior to effectively behave as
> rotating log. That is, if user-supplied log buffer turns out to be too
> short, instead of failing with -ENOSPC, verifier will keep overwriting
> previously written log, effectively treating user's log buffer as a ring
> buffer.
>=20
> Importantly, though, to preserve good user experience and not require
> every user-space application to adopt to this new behavior, before
> exiting to user-space verifier will rotate log (in place) to make it
> start at the very beginning of user buffer as a continuous
> zero-terminated string. The contents will be a chopped off N-1 last
> bytes of full verifier log, of course.
>=20
> Given beginning of log is sometimes important as well, we add
> BPF_LOG_FIXED (which equals 8) flag to force old behavior, which allows
> tools like veristat to request first part of verifier log, if necessary.
>=20
> On the implementation side, conceptually, it's all simple. We maintain
> 64-bit logical start and end positions. If we need to truncate the log,
> start position will be adjusted accordingly to lag end position by
> N bytes. We then use those logical positions to calculate their matching
> actual positions in user buffer and handle wrap around the end of the
> buffer properly. Finally, right before returning from bpf_check(), we
> rotate user log buffer contents in-place as necessary, to make log
> contents contiguous. See comments in relevant functions for details.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

I tried bpf_verifier_vlog() and bpf_vlog_finalize() using some
randomized testing + valgrind and everything seems to be fine.
Tbh, it seems to me that having kunit tests for things like this might
be a good idea.

Test script for reference:

  void once(char *in, size_t out_sz) {
  	struct bpf_verifier_log log =3D {};
  	char *out =3D calloc(out_sz, 1);
  	size_t in_sz =3D strlen(in);
  	size_t orig_out_sz =3D out_sz;
 =20
  	log.ubuf =3D out;
  	log.len_total =3D out_sz;
  	log.level =3D 1 | 2 | 4;
 =20
  	for (char *input =3D strtok(in, " "); input; input =3D strtok(NULL, " ")=
)
  		bpf_verifier_vlog(&log, input);
 =20
  	bpf_vlog_finalize(&log);
 =20
  	for (unsigned i =3D 0; i < in_sz; ++i)
  		if (in[i] =3D=3D 0)
  			in[i] =3D ' ';
 =20
  	out_sz =3D strlen(out);
  	if (in_sz)
  		--in_sz;
  	if (out_sz)
  		--out_sz;
  	while (out_sz > 0 && in_sz > 0) {
  		if (in[in_sz] =3D=3D ' ') {
  			--in_sz;
  			continue;
  		}
  		if (in[in_sz] =3D=3D out[out_sz]) {
  			--in_sz;
  			--out_sz;
  			continue;
  		}
  		printf("    in: '%s'\n", in);
  		printf("   out: '%s'\n", out);
  		printf("err at: %lu\n", out_sz);
  		printf("out_sz: %lu\n", orig_out_sz);
  		break;
  	}
 =20
  	free(out);
  }
 =20
  void rnd_once() {
  	char in[1024] =3D {};
  	size_t out_sz =3D 1 + rand() % 100;
  	size_t in_sz =3D rand() % (sizeof(in) - 1);
  	int cnt =3D 0;
 =20
  	for (unsigned i =3D 0; i < in_sz; ++i)
  		if (rand() % 100 < 7)
  			in[i] =3D ' ';
  		else
  			in[i] =3D 'a' + (rand() % 26);
 =20
  	once(in, out_sz);
  }
 =20
  int main(int argc, char **argv) {
	if (argc =3D=3D 3) {
		once(argv[2], atoi(argv[1]));
	} else {
		srand(clock());
		for (int i =3D 0; i < 100000; ++i)
			rnd_once();
	}
  }

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  include/linux/bpf_verifier.h                  |  32 ++-
>  kernel/bpf/log.c                              | 182 +++++++++++++++++-
>  kernel/bpf/verifier.c                         |  17 +-
>  .../selftests/bpf/prog_tests/log_fixup.c      |   1 +
>  4 files changed, 209 insertions(+), 23 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 83dff25545ee..cff11c99ed9a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -491,25 +491,42 @@ struct bpf_insn_aux_data {
>  #define BPF_VERIFIER_TMP_LOG_SIZE	1024
> =20
>  struct bpf_verifier_log {
> -	u32 level;
> -	char kbuf[BPF_VERIFIER_TMP_LOG_SIZE];
> +	/* Logical start and end positions of a "log window" of the verifier lo=
g.
> +	 * start_pos =3D=3D 0 means we haven't truncated anything.
> +	 * Once truncation starts to happen, start_pos + len_total =3D=3D end_p=
os,
> +	 * except during log reset situations, in which (end_pos - start_pos)
> +	 * might get smaller than len_total (see bpf_vlog_reset()).
> +	 * Generally, (end_pos - start_pos) gives number of useful data in
> +	 * user log buffer.
> +	 */
> +	u64 start_pos;
> +	u64 end_pos;
>  	char __user *ubuf;
> -	u32 len_used;
> +	u32 level;
>  	u32 len_total;
> +	char kbuf[BPF_VERIFIER_TMP_LOG_SIZE];
>  };
> =20
>  #define BPF_LOG_LEVEL1	1
>  #define BPF_LOG_LEVEL2	2
>  #define BPF_LOG_STATS	4
> +#define BPF_LOG_FIXED	8
>  #define BPF_LOG_LEVEL	(BPF_LOG_LEVEL1 | BPF_LOG_LEVEL2)
> -#define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS)
> +#define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS | BPF_LOG_FIXED)
>  #define BPF_LOG_KERNEL	(BPF_LOG_MASK + 1) /* kernel internal flag */
>  #define BPF_LOG_MIN_ALIGNMENT 8U
>  #define BPF_LOG_ALIGNMENT 40U
> =20
> +static inline u32 bpf_log_used(const struct bpf_verifier_log *log)
> +{
> +	return log->end_pos - log->start_pos;
> +}
> +
>  static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *=
log)
>  {
> -	return log->len_used >=3D log->len_total - 1;
> +	if (log->level & BPF_LOG_FIXED)
> +		return bpf_log_used(log) >=3D log->len_total - 1;
> +	return false;
>  }
> =20
>  static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log=
 *log)
> @@ -596,7 +613,7 @@ struct bpf_verifier_env {
>  	u32 scratched_regs;
>  	/* Same as scratched_regs but for stack slots */
>  	u64 scratched_stack_slots;
> -	u32 prev_log_len, prev_insn_print_len;
> +	u64 prev_log_pos, prev_insn_print_pos;
>  	/* buffer used in reg_type_str() to generate reg_type string */
>  	char type_str_buf[TYPE_STR_BUF_LEN];
>  };
> @@ -608,7 +625,8 @@ __printf(2, 3) void bpf_verifier_log_write(struct bpf=
_verifier_env *env,
>  					   const char *fmt, ...);
>  __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
>  			    const char *fmt, ...);
> -void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos);
> +void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
> +void bpf_vlog_finalize(struct bpf_verifier_log *log);
> =20
>  static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *e=
nv)
>  {
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 1974891fc324..ec640828e84e 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -32,26 +32,192 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log,=
 const char *fmt,
>  		return;
>  	}
> =20
> -	n =3D min(log->len_total - log->len_used - 1, n);
> -	log->kbuf[n] =3D '\0';
> -	if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
> -		log->len_used +=3D n;
> -	else
> -		log->ubuf =3D NULL;
> +	if (log->level & BPF_LOG_FIXED) {
> +		n =3D min(log->len_total - bpf_log_used(log) - 1, n);
> +		log->kbuf[n] =3D '\0';
> +		n +=3D 1;
> +
> +		if (copy_to_user(log->ubuf + log->end_pos, log->kbuf, n))
> +			goto fail;
> +
> +		log->end_pos +=3D n - 1; /* don't count terminating '\0' */
> +	} else {
> +		u64 new_end, new_start, cur_pos;
> +		u32 buf_start, buf_end, new_n;
> +
> +		log->kbuf[n] =3D '\0';
> +		n +=3D 1;
> +
> +		new_end =3D log->end_pos + n;
> +		if (new_end - log->start_pos >=3D log->len_total)
> +			new_start =3D new_end - log->len_total;
> +		else
> +			new_start =3D log->start_pos;
> +		new_n =3D min(n, log->len_total);
> +		cur_pos =3D new_end - new_n;
> +
> +		buf_start =3D cur_pos % log->len_total;
> +		buf_end =3D new_end % log->len_total;
> +		/* new_end and buf_end are exclusive indices, so if buf_end is
> +		 * exactly zero, then it actually points right to the end of
> +		 * ubuf and there is no wrap around
> +		 */
> +		if (buf_end =3D=3D 0)
> +			buf_end =3D log->len_total;
> +
> +		/* if buf_start > buf_end, we wrapped around;
> +		 * if buf_start =3D=3D buf_end, then we fill ubuf completely; we
> +		 * can't have buf_start =3D=3D buf_end to mean that there is
> +		 * nothing to write, because we always write at least
> +		 * something, even if terminal '\0'
> +		 */
> +		if (buf_start < buf_end) {
> +			/* message fits within contiguous chunk of ubuf */
> +			if (copy_to_user(log->ubuf + buf_start,
> +					 log->kbuf + n - new_n,
> +					 buf_end - buf_start))
> +				goto fail;
> +		} else {
> +			/* message wraps around the end of ubuf, copy in two chunks */
> +			if (copy_to_user(log->ubuf + buf_start,
> +					 log->kbuf + n - new_n,
> +					 log->len_total - buf_start))
> +				goto fail;
> +			if (copy_to_user(log->ubuf,
> +					 log->kbuf + n - buf_end,
> +					 buf_end))
> +				goto fail;
> +		}
> +
> +		log->start_pos =3D new_start;
> +		log->end_pos =3D new_end - 1; /* don't count terminating '\0' */
> +	}
> +
> +	return;
> +fail:
> +	log->ubuf =3D NULL;
>  }
> =20
> -void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos)
> +void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
>  {
>  	char zero =3D 0;
> =20
>  	if (!bpf_verifier_log_needed(log))
>  		return;
> =20
> -	log->len_used =3D new_pos;
> +	/* if position to which we reset is beyond current log window, then we
> +	 * didn't preserve any useful content and should adjust adjust
> +	 * start_pos to end up with an empty log (start_pos =3D=3D end_pos)
> +	 */
> +	log->end_pos =3D new_pos;
> +	if (log->end_pos < log->start_pos)
> +		log->start_pos =3D log->end_pos;
> +
>  	if (put_user(zero, log->ubuf + new_pos))
>  		log->ubuf =3D NULL;
>  }
> =20
> +static void bpf_vlog_reverse_kbuf(char *buf, int len)
> +{
> +	int i, j;
> +
> +	for (i =3D 0, j =3D len - 1; i < j; i++, j--)
> +		swap(buf[i], buf[j]);
> +}
> +
> +static int bpf_vlog_reverse_ubuf(struct bpf_verifier_log *log, int start=
, int end)
> +{
> +	/* we split log->kbuf into two equal parts for both ends of array */
> +	int n =3D sizeof(log->kbuf) / 2, nn;
> +	char *lbuf =3D log->kbuf, *rbuf =3D log->kbuf + n;
> +
> +	/* Read ubuf's section [start, end) two chunks at a time, from left
> +	 * and right side; within each chunk, swap all the bytes; after that
> +	 * reverse the order of lbuf and rbuf and write result back to ubuf.
> +	 * This way we'll end up with swapped contents of specified
> +	 * [start, end) ubuf segment.
> +	 */
> +	while (end - start > 1) {
> +		nn =3D min(n, (end - start ) / 2);
> +
> +		if (copy_from_user(lbuf, log->ubuf + start, nn))
> +			return -EFAULT;
> +		if (copy_from_user(rbuf, log->ubuf + end - nn, nn))
> +			return -EFAULT;
> +
> +		bpf_vlog_reverse_kbuf(lbuf, nn);
> +		bpf_vlog_reverse_kbuf(rbuf, nn);
> +
> +		/* we write lbuf to the right end of ubuf, while rbuf to the
> +		 * left one to end up with properly reversed overall ubuf
> +		 */
> +		if (copy_to_user(log->ubuf + start, rbuf, nn))
> +			return -EFAULT;
> +		if (copy_to_user(log->ubuf + end - nn, lbuf, nn))
> +			return -EFAULT;
> +
> +		start +=3D nn;
> +		end -=3D nn;
> +	}
> +
> +	return 0;
> +}
> +
> +void bpf_vlog_finalize(struct bpf_verifier_log *log)
> +{
> +	u32 sublen;
> +	int err;
> +
> +	if (!log || !log->level || !log->ubuf)
> +		return;
> +	if ((log->level & BPF_LOG_FIXED) || log->level =3D=3D BPF_LOG_KERNEL)
> +		return;
> +
> +	/* If we never truncated log, there is nothing to move around. */
> +	if (log->start_pos =3D=3D 0)
> +		return;
> +
> +	/* Otherwise we need to rotate log contents to make it start from the
> +	 * buffer beginning and be a continuous zero-terminated string. Note
> +	 * that if log->start_pos !=3D 0 then we definitely filled up entire lo=
g
> +	 * buffer with no gaps, and we just need to shift buffer contents to
> +	 * the left by (log->start_pos % log->len_total) bytes.
> +	 *
> +	 * Unfortunately, user buffer could be huge and we don't want to
> +	 * allocate temporary kernel memory of the same size just to shift
> +	 * contents in a straightforward fashion. Instead, we'll be clever and
> +	 * do in-place array rotation. This is a leetcode-style problem, which
> +	 * could be solved by three rotations.
> +	 *
> +	 * Let's say we have log buffer that has to be shifted left by 7 bytes
> +	 * (spaces and vertical bar is just for demonstrative purposes):
> +	 *   E F G H I J K | A B C D
> +	 *
> +	 * First, we reverse entire array:
> +	 *   D C B A | K J I H G F E
> +	 *
> +	 * Then we rotate first 4 bytes (DCBA) and separately last 7 bytes
> +	 * (KJIHGFE), resulting in a properly rotated array:
> +	 *   A B C D | E F G H I J K
> +	 *
> +	 * We'll utilize log->kbuf to read user memory chunk by chunk, swap
> +	 * bytes, and write them back. Doing it byte-by-byte would be
> +	 * unnecessarily inefficient. Altogether we are going to read and
> +	 * write each byte twice.
> +	 */
> +
> +	/* length of the chopped off part that will be the beginning;
> +	 * len(ABCD) in the example above
> +	 */
> +	sublen =3D log->len_total - (log->start_pos % log->len_total);
> +
> +	err =3D bpf_vlog_reverse_ubuf(log, 0, log->len_total);
> +	err =3D err ?: bpf_vlog_reverse_ubuf(log, 0, sublen);
> +	err =3D err ?: bpf_vlog_reverse_ubuf(log, sublen, log->len_total);
> +	if (err)
> +		log->ubuf =3D NULL;
> +}
> +
>  /* log_level controls verbosity level of eBPF verifier.
>   * bpf_verifier_log_write() is used to dump the verification trace to th=
e log,
>   * so the user can figure out what's wrong with the program
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 203d6e644e44..f6d3d448e1b1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1435,10 +1435,10 @@ static inline u32 vlog_alignment(u32 pos)
>  static void print_insn_state(struct bpf_verifier_env *env,
>  			     const struct bpf_func_state *state)
>  {
> -	if (env->prev_log_len && env->prev_log_len =3D=3D env->log.len_used) {
> +	if (env->prev_log_pos && env->prev_log_pos =3D=3D env->log.end_pos) {
>  		/* remove new line character */
> -		bpf_vlog_reset(&env->log, env->prev_log_len - 1);
> -		verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_len), ' ');
> +		bpf_vlog_reset(&env->log, env->prev_log_pos - 1);
> +		verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_pos), ' ');
>  	} else {
>  		verbose(env, "%d:", env->insn_idx);
>  	}
> @@ -1746,7 +1746,7 @@ static struct bpf_verifier_state *push_stack(struct=
 bpf_verifier_env *env,
>  	elem->insn_idx =3D insn_idx;
>  	elem->prev_insn_idx =3D prev_insn_idx;
>  	elem->next =3D env->head;
> -	elem->log_pos =3D env->log.len_used;
> +	elem->log_pos =3D env->log.end_pos;
>  	env->head =3D elem;
>  	env->stack_size++;
>  	err =3D copy_verifier_state(&elem->st, cur);
> @@ -2282,7 +2282,7 @@ static struct bpf_verifier_state *push_async_cb(str=
uct bpf_verifier_env *env,
>  	elem->insn_idx =3D insn_idx;
>  	elem->prev_insn_idx =3D prev_insn_idx;
>  	elem->next =3D env->head;
> -	elem->log_pos =3D env->log.len_used;
> +	elem->log_pos =3D env->log.end_pos;
>  	env->head =3D elem;
>  	env->stack_size++;
>  	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
> @@ -15563,11 +15563,11 @@ static int do_check(struct bpf_verifier_env *en=
v)
>  				print_insn_state(env, state->frame[state->curframe]);
> =20
>  			verbose_linfo(env, env->insn_idx, "; ");
> -			env->prev_log_len =3D env->log.len_used;
> +			env->prev_log_pos =3D env->log.end_pos;
>  			verbose(env, "%d: ", env->insn_idx);
>  			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
> -			env->prev_insn_print_len =3D env->log.len_used - env->prev_log_len;
> -			env->prev_log_len =3D env->log.len_used;
> +			env->prev_insn_print_pos =3D env->log.end_pos - env->prev_log_pos;
> +			env->prev_log_pos =3D env->log.end_pos;
>  		}
> =20
>  		if (bpf_prog_is_offloaded(env->prog->aux)) {
> @@ -18780,6 +18780,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr)
>  	print_verification_stats(env);
>  	env->prog->aux->verified_insns =3D env->insn_processed;
> =20
> +	bpf_vlog_finalize(log);
>  	if (log->level && bpf_verifier_log_full(log))
>  		ret =3D -ENOSPC;
>  	if (log->level && !log->ubuf) {
> diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/t=
esting/selftests/bpf/prog_tests/log_fixup.c
> index 239e1c5753b0..bc27170bdeb0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
> @@ -24,6 +24,7 @@ static void bad_core_relo(size_t log_buf_size, enum tru=
nc_type trunc_type)
>  	bpf_program__set_autoload(skel->progs.bad_relo, true);
>  	memset(log_buf, 0, sizeof(log_buf));
>  	bpf_program__set_log_buf(skel->progs.bad_relo, log_buf, log_buf_size ?:=
 sizeof(log_buf));
> +	bpf_program__set_log_level(skel->progs.bad_relo, 1 | 8); /* BPF_LOG_FIX=
ED to force truncation */
> =20
>  	err =3D test_log_fixup__load(skel);
>  	if (!ASSERT_ERR(err, "load_fail"))

