Return-Path: <bpf+bounces-59888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7764AD0708
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D0A1896067
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CEF289E29;
	Fri,  6 Jun 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laQKy3oz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E1289E12
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228826; cv=none; b=NOEzVWtIpoqrPszQFmYcDPyU0tgcOgQqLEpCDQ14gxF1w1xcg7c76cC5ppxOJC3PPZfGmrh3tu/AhSCgjcJf2hPoFdCcvB2zA4VxYKK98fwIsxDjovKli1oFlpBxoXNzmlkY0myxMf4USFuTeeQs7M9n2/vQdfZ4CYVsBCZWfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228826; c=relaxed/simple;
	bh=q1vYNCty9DVBV3a5LPLHxIgJejCmLvEEAi+3BYvkfS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvfG42Q3KUKlSl1bWjjC/c60Zt9MowNFPFNBTEVpoTUtMpsnZ4o/n5B1MCN/3Ui8WVt1PehsoWzAZBi2n8XhOYzLngHqrCYacuXU96EfS8SoqsfiIdh4Bci7ELqgSIEXCxYWJkKZLlcfhEJHEbFw97HQh3vnkjnWdJnKvRBeXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laQKy3oz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso4406852a12.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749228822; x=1749833622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NaolGs5XvQTEZdhxRCpbAwDiND+m+lvEarfM2eXq8gg=;
        b=laQKy3ozdNHnUBp3UI+xtIoKsISjsZFvwOUaWMRjQmc8Ak5aMAhZ3XCapmNRJ+OVZ4
         CzKgqRA7AOEUe5tFAB0F9eU9vJG8OMio157y+4lKlzkEvmwGY3HKzBDzqqKmXDTn9dzL
         p1oJEV7FDqUvahiw8el7frc2uN5IbiXNh+SKICrtj73jw+IIFNfzMGznP1mRELdLxv8Z
         ynzeF1bbg2z8DbW839ojzFrMEOxJIQbKxKP/FyuhWrN3N0cCUatVugVv3AFPtauP9l0s
         BNBU17GzC0cM6PwZYypD5x93oUxWqjhm3aXmkFdmNLZpR1G0TZp+Ts0qFXS40b2Ikecr
         yPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749228822; x=1749833622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NaolGs5XvQTEZdhxRCpbAwDiND+m+lvEarfM2eXq8gg=;
        b=YfwlB9fsV7Zu8xVeyAdkDc4YuCJCFor8GbDXOif29vNHqmTXsYqxWUirefYOhVVu4W
         vqZVcvUL2nR+DR3oip2l7Ucthd0asIDi3INmu/x2txUVITz89LcYlORgLIjtrtd4ZQwz
         KCK3yEhdcFYvFqBhSYWn38VgBmAxqEXczbM0/kFPrjYtoUU3GHqGURAXBMmAXoAS0z/4
         DMXMUDjONPqzO6m+AVLu+Js9Q5PuuXVRghLdMTP3Jb/COWuAkYhw6FRgZsOPPvs+m0g5
         yRiY1RhARW6a3YKrY4IZ2JODbn+JADtqfpvJj1t22FeIKZRtXtqeTmeTcUztFyc+qycc
         GMww==
X-Forwarded-Encrypted: i=1; AJvYcCWnTy7YgdN9a8AiiZMhOM8TeTTCEWAUnk/xCO8hbrA3GNeVryyaeXTHr2AeDBAAL52JkZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4qZOgqxYxIwd9zLXc6yZYa6iCymQ31zXcimAqx/kCL668AilH
	C9R1jXJ6FRPu19XyrEvgD/770YuqXjK12O4l1/9dCrVNxp1uB+k8XRpk
X-Gm-Gg: ASbGncvmaVaeYcogSqvS1tNul6J5TCxiGy6RPxULDM+9mJNWPdQEVvZnKZTKi+Hb7H/
	Ni3nhmWZ+L2sdwTM83KtuJiIKtQVKXnZUQ388SkrocW2YweqL+O2959nS5E19IUpAr6lDwrkO8J
	wmGqMScBJH2sKc3gfN/UWF7FPPc9CLMM78lhU3gigKMMQWCfszsYyh5MEgIFXE39Pu5mp7wjeFO
	DOEyowYvfXIma+enk/Rp75AsH2cowZs2aT3TUbayzIOS0dAsaOHtBz4XiCwNkeY/cp2hSE+n0Xd
	098t2Tzqf+HJ91JNI+wooQarURACx2dlA1otxPhupvI7jLsf4Ulj+Og2ZUZg75mVY0kXag==
X-Google-Smtp-Source: AGHT+IEMhphvXVYNZDPiVlHVoa9GeASILEV+zX5uKLUpNBmdHhjf0Timr0hm4QfNX4TcR51Uvh8g9Q==
X-Received: by 2002:a17:907:3ea7:b0:ade:7f2:a160 with SMTP id a640c23a62f3a-ade1a9e809amr363771066b.48.1749228822067;
        Fri, 06 Jun 2025 09:53:42 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::27d? ([2620:10d:c092:600::1:e4b0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db55aa2sm141290966b.45.2025.06.06.09.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 09:53:41 -0700 (PDT)
Message-ID: <3dd16f19-63a4-4090-abd0-9b84fb07346b@gmail.com>
Date: Fri, 6 Jun 2025 17:53:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf
 programs
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev
References: <20250605230609.1444980-1-eddyz87@gmail.com>
 <20250605230609.1444980-3-eddyz87@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250605230609.1444980-3-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/25 00:06, Eduard Zingerman wrote:
> This commit adds a new field mem_peak / "Peak memory" field to a set
> of gathered statistics. The field is intended as an estimate for peak
> verifier memory consumption for processing of a given program.
>
> Mechanically stat is collected as follows:
> - At the beginning of handle_verif_mode() a new cgroup namespace is
>    created and cgroup fs is mounted in this namespace, memory
>    controller is enabled for the root cgroup.
> - At each program load:
>    - bpf_object__load() is split into bpf_object__prepare() and
>      bpf_object__load() to avoid accounting for memory allocated for
>      maps;
>    - before bpf_object__load() a new cgroup is created and veristat
>      process enters this cgroup, "memory.peak" of the new cgroup is
>      stashed;
>    - after bpf_object__load() the difference between current
>      "memory.peak" and stashed "memory.peak" is used as a metric,
>      veristat exits the cgroup and cgroup is discarded.
>
> If any of the above steps fails veristat would proceed w/o collecting
> mem_peak information for a program.
>
> The change has impact on veristat running time, e.g. for all
> test_progs object files there is an increase from 82s to 102s.
>
> I take a correlation between "Peak states" and "Peak memory" fields as
> a sanity check for gathered statistics, e.g. here is a sample of data
> for sched_ext programs:
>
> File       Program               Peak states  Peak memory (KiB)
> ---------  --------------------  -----------  -----------------
> bpf.bpf.o  lavd_select_cpu              1311              26256
> bpf.bpf.o  lavd_enqueue                 1140              22720
> bpf.bpf.o  layered_enqueue               777              11504
> bpf.bpf.o  layered_dispatch              578               7976
> bpf.bpf.o  lavd_dispatch                 634               6204
> bpf.bpf.o  rusty_init                    343               5352
> bpf.bpf.o  lavd_init                     361               5092
> ...
> bpf.bpf.o  rusty_exit_task                36                256
> bpf.bpf.o  rusty_running                  19                256
> bpf.bpf.o  bpfland_dispatch                3                  0
> bpf.bpf.o  bpfland_enable                  1                  0
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   tools/testing/selftests/bpf/veristat.c | 249 ++++++++++++++++++++++++-
>   1 file changed, 242 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
> index b2bb20b00952..e68f5dda5278 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -12,6 +12,7 @@
>   #include <signal.h>
>   #include <fcntl.h>
>   #include <unistd.h>
> +#include <sys/mount.h>
>   #include <sys/time.h>
>   #include <sys/sysinfo.h>
>   #include <sys/stat.h>
> @@ -49,6 +50,7 @@ enum stat_id {
>   	STACK,
>   	PROG_TYPE,
>   	ATTACH_TYPE,
> +	MEMORY_PEAK,
>   
>   	FILE_NAME,
>   	PROG_NAME,
> @@ -208,6 +210,9 @@ static struct env {
>   	int top_src_lines;
>   	struct var_preset *presets;
>   	int npresets;
> +	char cgroup_fs_mount[PATH_MAX + 1];
> +	char stat_cgroup[PATH_MAX + 1];
> +	int memory_peak_fd;
>   } env;
>   
>   static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
> @@ -219,6 +224,22 @@ static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va
>   	return vfprintf(stderr, format, args);
>   }
>   
> +#define log_errno(fmt, ...) log_errno_aux(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
> +
> +__printf(3, 4)
> +static int log_errno_aux(const char *file, int line, const char *fmt, ...)
> +{
> +	int err = -errno;
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	fprintf(stderr, "%s:%d: ", file, line);
> +	vfprintf(stderr, fmt, ap);
> +	fprintf(stderr, " failed with error '%s'\n", strerror(errno));
> +	va_end(ap);
> +	return err;
> +}
> +
>   #ifndef VERISTAT_VERSION
>   #define VERISTAT_VERSION "<kernel>"
>   #endif
> @@ -734,13 +755,13 @@ static int append_file_from_file(const char *path)
>   }
>   
>   static const struct stat_specs default_csv_output_spec = {
> -	.spec_cnt = 14,
> +	.spec_cnt = 15,
>   	.ids = {
>   		FILE_NAME, PROG_NAME, VERDICT, DURATION,
>   		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
>   		MAX_STATES_PER_INSN, MARK_READ_MAX_LEN,
>   		SIZE, JITED_SIZE, PROG_TYPE, ATTACH_TYPE,
> -		STACK,
> +		STACK, MEMORY_PEAK,
>   	},
>   };
>   
> @@ -781,6 +802,7 @@ static struct stat_def {
>   	[STACK] = {"Stack depth", {"stack_depth", "stack"}, },
>   	[PROG_TYPE] = { "Program type", {"prog_type"}, },
>   	[ATTACH_TYPE] = { "Attach type", {"attach_type", }, },
> +	[MEMORY_PEAK] = { "Peak memory (KiB)", {"mem_peak", }, },
>   };
>   
>   static bool parse_stat_id_var(const char *name, size_t len, int *id,
> @@ -1278,16 +1300,213 @@ static int max_verifier_log_size(void)
>   	return log_size;
>   }
>   
> +__printf(2, 3)
> +static int write_one_line(const char *file, const char *fmt, ...)
> +{
> +	int err, saved_errno;
> +	va_list ap;
> +	FILE *f;
> +
> +	f = fopen(file, "w");
> +	if (!f)
> +		return -1;
> +
> +	va_start(ap, fmt);
> +	errno = 0;
> +	err = vfprintf(f, fmt, ap);
> +	saved_errno = errno;
> +	va_end(ap);
> +	fclose(f);
> +	errno = saved_errno;
> +	return err < 0 ? -1 : 0;
> +}
> +
> +/*
> + * This works around GCC warning about snprintf truncating strings like:
> + *
> + *   char a[PATH_MAX], b[PATH_MAX];
> + *   snprintf(a, "%s/foo", b);      // triggers -Wformat-truncation
> + */
> +__printf(3, 4)
> +static int snprintf_trunc(char *str, volatile size_t size, const char *fmt, ...)
> +{
> +	va_list ap;
> +	int ret;
> +
> +	va_start(ap, fmt);
> +	ret = vsnprintf(str, size, fmt, ap);
> +	va_end(ap);
> +	return ret;
> +}
> +
> +static void destroy_stat_cgroup(void);
> +static void umount_cgroupfs(void);
> +
> +/*
> + * Enters new cgroup namespace and mounts cgroupfs at /tmp/veristat-cgroup-mount-XXXXXX,
> + * enables "memory" controller for the root cgroup.
> + */
> +static int mount_cgroupfs(void)
> +{
> +	char buf[PATH_MAX + 1];
> +	int err;
> +
> +	env.memory_peak_fd = -1;
> +
> +	err = unshare(CLONE_NEWCGROUP);
> +	if (err < 0) {
> +		err = log_errno("unshare(CLONE_NEWCGROUP)");
> +		goto err_out;
> +	}
> +
> +	snprintf_trunc(buf, sizeof(buf), "%s/veristat-cgroup-mount-XXXXXX", P_tmpdir);
> +	if (mkdtemp(buf) == NULL) {
> +		err = log_errno("mkdtemp(%s)", buf);
> +		goto err_out;
> +	}
> +	strcpy(env.cgroup_fs_mount, buf);
> +
> +	err = mount("none", env.cgroup_fs_mount, "cgroup2", 0, NULL);
> +	if (err < 0) {
> +		err = log_errno("mount none %s -t cgroup2", env.cgroup_fs_mount);
> +		goto err_out;
> +	}
> +
> +	snprintf_trunc(buf, sizeof(buf), "%s/cgroup.subtree_control", env.cgroup_fs_mount);
> +	err = write_one_line(buf, "+memory\n");
> +	if (err < 0) {
> +		err = log_errno("echo '+memory' > %s", buf);
> +		goto err_out;
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	umount_cgroupfs();
> +	return err;
> +}
> +
> +static void umount_cgroupfs(void)
> +{
> +	int err;
> +
> +	if (!env.cgroup_fs_mount[0])
> +		return;
> +
> +	err = umount(env.cgroup_fs_mount);
> +	if (err < 0)
> +		log_errno("umount %s", env.cgroup_fs_mount);
> +
> +	err = rmdir(env.cgroup_fs_mount);
> +	if (err < 0)
> +		log_errno("rmdir %s", env.cgroup_fs_mount);
> +
> +	env.cgroup_fs_mount[0] = 0;
> +}
> +
> +/*
> + * Creates a cgroup at /tmp/veristat-cgroup-mount-XXXXXX/accounting-<pid>,
> + * moves current process to this cgroup.
> + */
> +static int create_stat_cgroup(void)
> +{
> +	char buf[PATH_MAX + 1];
> +	int err;
> +
> +	if (!env.cgroup_fs_mount[0])
> +		return -1;
> +
> +	env.memory_peak_fd = -1;
> +
> +	snprintf_trunc(buf, sizeof(buf), "%s/accounting-%d", env.cgroup_fs_mount, getpid());
> +	err = mkdir(buf, 0777);
> +	if (err < 0) {
> +		err = log_errno("mkdir(%s)", buf);
> +		goto err_out;
> +	}
> +	strcpy(env.stat_cgroup, buf);
> +
> +	snprintf_trunc(buf, sizeof(buf), "%s/cgroup.procs", env.stat_cgroup);
> +	err = write_one_line(buf, "%d\n", getpid());
> +	if (err < 0) {
> +		err = log_errno("echo %d > %s", getpid(), buf);
> +		goto err_out;
> +	}
> +
> +	snprintf_trunc(buf, sizeof(buf), "%s/memory.peak", env.stat_cgroup);
> +	env.memory_peak_fd = open(buf, O_RDWR | O_APPEND);
Why is it necessary to open in RW|APPEND mode? Won't O_RDONLY cut it?
> +	if (env.memory_peak_fd < 0) {
> +		err = log_errno("open(%s)", buf);
> +		goto err_out;
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	destroy_stat_cgroup();
> +	return err;
> +}
> +
> +static void destroy_stat_cgroup(void)
> +{
> +	char buf[PATH_MAX];
> +	int err;
> +
> +	close(env.memory_peak_fd);
> +
> +	if (env.cgroup_fs_mount[0]) {
> +		snprintf_trunc(buf, sizeof(buf), "%s/cgroup.procs", env.cgroup_fs_mount);
> +		err = write_one_line(buf, "%d\n", getpid());
> +		if (err < 0)
> +			log_errno("echo %d > %s", getpid(), buf);
> +	}
> +
> +	if (env.stat_cgroup[0]) {
> +		err = rmdir(env.stat_cgroup);
> +		if (err < 0)
> +			log_errno("rmdir %s", env.stat_cgroup);
> +	}
> +
> +	env.stat_cgroup[0] = 0;
> +}
> +
> +/* Current value of /tmp/veristat-cgroup-mount-XXXXXX/accounting-<pid>/memory.peak */
> +static long cgroup_memory_peak(void)
> +{
> +	long err, memory_peak;
> +	char buf[32];
> +
> +	if (env.memory_peak_fd < 0)
> +		return -1;
> +
> +	err = pread(env.memory_peak_fd, buf, sizeof(buf) - 1, 0);
> +	if (err <= 0) {
> +		log_errno("read(%s/memory.peak)", env.stat_cgroup);
> +		return -1;
> +	}
> +
> +	buf[err] = 0;
nit: maybe rename err to len here?
> +	errno = 0;
> +	memory_peak = strtoll(buf, NULL, 10);
> +	if (errno) {
> +		log_errno("unrecognized %s/memory.peak format: %s", env.stat_cgroup, buf);
> +		return -1;
> +	}
> +
> +	return memory_peak;
> +}
> +
>   static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
>   {
>   	const char *base_filename = basename(strdupa(filename));
>   	const char *prog_name = bpf_program__name(prog);
> +	long mem_peak_a, mem_peak_b, mem_peak = -1;
>   	char *buf;
>   	int buf_sz, log_level;
>   	struct verif_stats *stats;
>   	struct bpf_prog_info info;
>   	__u32 info_len = sizeof(info);
> -	int err = 0;
> +	int err = 0, cgroup_err;
>   	void *tmp;
>   	int fd;
>   
> @@ -1332,7 +1551,16 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>   	if (env.force_reg_invariants)
>   		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_REG_INVARIANTS);
>   
> -	err = bpf_object__load(obj);
> +	err = bpf_object__prepare(obj);
> +	if (!err) {
> +		cgroup_err = create_stat_cgroup();
> +		mem_peak_a = cgroup_memory_peak();
> +		err = bpf_object__load(obj);
> +		mem_peak_b = cgroup_memory_peak();
> +		destroy_stat_cgroup();
What if we do create_stat_cgroup/destory_stat_cgroup in 
handle_verif_mode along with mount/umount_cgroupfs.
It may speed things up a little bit here and moving all cgroup 
preparations into the single place seems reasonable.
Will memory counter behave differently? We are checking the difference 
around bpf_object__load, from layman's
perspective it should be the same.
> +		if (!cgroup_err && mem_peak_a >= 0 && mem_peak_b >= 0)
> +			mem_peak = mem_peak_b - mem_peak_a;
> +	}
>   	env.progs_processed++;
>   
>   	stats->file_name = strdup(base_filename);
> @@ -1341,6 +1569,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>   	stats->stats[SIZE] = bpf_program__insn_cnt(prog);
>   	stats->stats[PROG_TYPE] = bpf_program__type(prog);
>   	stats->stats[ATTACH_TYPE] = bpf_program__expected_attach_type(prog);
> +	stats->stats[MEMORY_PEAK] = mem_peak < 0 ? -1 : mem_peak / 1024;
>   
>   	memset(&info, 0, info_len);
>   	fd = bpf_program__fd(prog);
> @@ -1824,6 +2053,7 @@ static int cmp_stat(const struct verif_stats *s1, const struct verif_stats *s2,
>   	case TOTAL_STATES:
>   	case PEAK_STATES:
>   	case MAX_STATES_PER_INSN:
> +	case MEMORY_PEAK:
>   	case MARK_READ_MAX_LEN: {
>   		long v1 = s1->stats[id];
>   		long v2 = s2->stats[id];
> @@ -2053,6 +2283,7 @@ static void prepare_value(const struct verif_stats *s, enum stat_id id,
>   	case STACK:
>   	case SIZE:
>   	case JITED_SIZE:
> +	case MEMORY_PEAK:
>   		*val = s ? s->stats[id] : 0;
>   		break;
>   	default:
> @@ -2139,6 +2370,7 @@ static int parse_stat_value(const char *str, enum stat_id id, struct verif_stats
>   	case MARK_READ_MAX_LEN:
>   	case SIZE:
>   	case JITED_SIZE:
> +	case MEMORY_PEAK:
>   	case STACK: {
>   		long val;
>   		int err, n;
> @@ -2776,7 +3008,7 @@ static void output_prog_stats(void)
>   
>   static int handle_verif_mode(void)
>   {
> -	int i, err;
> +	int i, err = 0;
>   
>   	if (env.filename_cnt == 0) {
>   		fprintf(stderr, "Please provide path to BPF object file!\n\n");
> @@ -2784,11 +3016,12 @@ static int handle_verif_mode(void)
>   		return -EINVAL;
>   	}
>   
> +	mount_cgroupfs();
>   	for (i = 0; i < env.filename_cnt; i++) {
>   		err = process_obj(env.filenames[i]);
>   		if (err) {
>   			fprintf(stderr, "Failed to process '%s': %d\n", env.filenames[i], err);
> -			return err;
> +			goto out;
>   		}
>   	}
>   
> @@ -2796,7 +3029,9 @@ static int handle_verif_mode(void)
>   
>   	output_prog_stats();
>   
> -	return 0;
> +out:
> +	umount_cgroupfs();
> +	return err;
>   }
>   
>   static int handle_replay_mode(void)
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

