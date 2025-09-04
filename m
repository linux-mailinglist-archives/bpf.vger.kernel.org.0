Return-Path: <bpf+bounces-67455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0BB441AF
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 17:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3A77B3DB3
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B538528134C;
	Thu,  4 Sep 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvecIW8N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E782D6E63
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001459; cv=none; b=g/qc/TRDHDiIutwTjcn1kK6J0T3IzU+dOnTtPP1r4FMtLpmMtIZIgxd6d6inkJkh0Xd5tD/FFCfctijEnaz39Q5JaGALifdUmmrDr+LpOKTssB4NwpVBdcgaEhbjcOrJ0VVb23iX4QzEVWDsV0aOtxmAwyZrE4VDpkrYhzmc0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001459; c=relaxed/simple;
	bh=jgvw/2OaIVoMF3Akp1cirW88r5Qs4FxXUUVkv+VcTL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvxheFAnvhFJTnN4ejKmwJZO3ExoOcRpbTf9Ze/qe0iJLfRPqANppozKjvtQtDEbKSk93Vu5KDPpX4U17x18l0CWb1R5yCeGEi75LK77YFoiXGaBkF6zhj6qAznQHEfh1sI3+ZBP7E+KSGHXw8TYd6Ink1yGO/eOV7lKHo2uQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvecIW8N; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3da4c14a5f9so1465432f8f.0
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757001456; x=1757606256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7WMsM3rPZw34+kYqfmtF12Movx9Ifa1Sa2Ss9fvy6E=;
        b=QvecIW8N+erTSeNls0vTHiI0VcgrXBPTpOCHItbJwTzFwwc5/zPoGQF+ST9r58G6hL
         f+5yFAUjcbtkuXed6a8KuVIHdB2ItVV4ySODMt+cxerclDXpmEECnrjGyCNGldgtK2sV
         jLuwL5q3uwIkFXjpY2VWs9AgJNatfMbTanb/xtNoKll7PFNzwdi1/JjNuvGptvxYpJZi
         GlTlIFyZwtac5Y2/qWXkz/011QvagNT7b1O89QRdt9pb1oaE+pjkN38e471dwrksrqKN
         0cya3PTONzv37TsPaDK/OrhsOTLaP3kwPXxSAXKM5Tswv5Oh66u5NEk8Tyfyf1am62A2
         uoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757001456; x=1757606256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7WMsM3rPZw34+kYqfmtF12Movx9Ifa1Sa2Ss9fvy6E=;
        b=EKyQM4FD3lWCF1/z1HxrEVRQQSa+l0T+K9zP8zWV5Hg3jXbfRoXyookAI4YnnR1+42
         NZJw0dibmBP8ZJTdZV1ok8D4nUlfxdGbs8+rV/WeaLBXhciyuUTzh3e3OhYunYuK4L19
         Tbte8qXEKNJcquuNiu60B9pqA8tnhV9tv8JtmvNhRk3T5uowegimvccBF+HdlWw4en2L
         bJ9WZn85TxBOCppECpdn/E0AT8OblGJ1Fi2BvgjM9QW76flCGDUtBwFbNkWbmmv9v8iv
         3pDNJe7iXyN12sfjL/NcC6VNQYRh+jpAbqPa57yTuhNeLZ6nCBH2Er1Qww2wY4GYtzjK
         KtZQ==
X-Gm-Message-State: AOJu0YyuTtAR9G+2clDvhO+chebaFX06hKxEGxZX4sy2OS5UjdaQ7H2R
	Mr3Lx9eJ/nBYNZ+ghdibgqWFkpK0DCFljkQTHlcVuhPUsEwLNulA8KJe
X-Gm-Gg: ASbGnctZg6q/wRkkA+/bQSYH1JuM0pASfUTWcKARCuud51vmXM1Qf3kxWB9poQr5i0N
	EPhHdXm891hoeU/+chxObwTjGvAa0DWKqGbF3D9FgIXvXkzPoLP6QuzmIjLwf9RKkVdJwK9b9Rp
	trVQ9ztjv0TxAlbQMahE47Ms1Yp6zcTt8/Jj5vnZz59chH/pL1qbrqHFScyW2mzsYJpPID+bnz5
	dfejjGOKbzuWiJWWKTgBnYmLJLwINvTKcIdQn8F8RQAXgdjHESa+rcIcpVvD12iEgtl4cmwgvxz
	kPiTxFFydUPII4hfcuaNsRrC9CTGYf8t/jyqGZaVC0X8tyubay52Uw60E07vufeKlinSCxTk8R2
	QysVutsqO2mRyB+1c7roRGy6UXT7CWVMFc+/djwUTc1LlJwibaHl5Iv9sNfpG0IUXx5/1qw==
X-Google-Smtp-Source: AGHT+IEC4MVoKuvLetaqqzZez3ftPo7zVaj1a+dkzFwbd8MxafPrVq/KWzgpSzIa4YyYjvzc+dNqTg==
X-Received: by 2002:a05:6000:24c8:b0:3d8:3eca:a97d with SMTP id ffacd0b85a97d-3e301757102mr153709f8f.11.1757001455290;
        Thu, 04 Sep 2025 08:57:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:a78f:73ed:bfe4:39e5? ([2620:10d:c092:500::4:217c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dc1cd4a7d2sm8322264f8f.33.2025.09.04.08.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 08:57:34 -0700 (PDT)
Message-ID: <542230e1-429b-4f8e-a4d9-60cb3d91aba9@gmail.com>
Date: Thu, 4 Sep 2025 16:57:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5] selftests/bpf: add BPF program dump in
 veristat
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250902233502.776885-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzZA-1HjhtKAz_4=N4DOsCuQZOrqCwJhDqVwH6fJPiiUKQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzZA-1HjhtKAz_4=N4DOsCuQZOrqCwJhDqVwH6fJPiiUKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/4/25 01:06, Andrii Nakryiko wrote:
> On Tue, Sep 2, 2025 at 4:35 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add the ability to dump BPF program instructions directly from veristat.
>> Previously, inspecting a program required separate bpftool invocations:
>> one to load and another to dump it, which meant running multiple
>> commands.
>> During active development, it's common for developers to use veristat
>> for testing verification. Integrating instruction dumping into veristat
>> reduces the need to switch tools and simplifies the workflow.
>> By making this information more readily accessible, this change aims
>> to streamline the BPF development cycle and improve usability for
>> developers.
>> This implementation leverages bpftool, by running it directly via popen
>> to avoid any code duplication and keep veristat simple.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/testing/selftests/bpf/veristat.c | 69 +++++++++++++++++++++++++-
>>   1 file changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>> index d532dd82a3a8..e27893863400 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
>> @@ -181,6 +181,12 @@ struct var_preset {
>>          bool applied;
>>   };
>>
>> +enum dump_mode {
>> +       DUMP_NONE = 0,
>> +       DUMP_XLATED = 1,
>> +       DUMP_JITED = 2,
>> +};
>> +
>>   static struct env {
>>          char **filenames;
>>          int filename_cnt;
>> @@ -227,6 +233,7 @@ static struct env {
>>          char orig_cgroup[PATH_MAX];
>>          char stat_cgroup[PATH_MAX];
>>          int memory_peak_fd;
>> +       __u32 dump_mode;
>>   } env;
>>
>>   static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
>> @@ -271,6 +278,7 @@ const char argp_program_doc[] =
>>   enum {
>>          OPT_LOG_FIXED = 1000,
>>          OPT_LOG_SIZE = 1001,
>> +       OPT_DUMP = 1002,
>>   };
>>
>>   static const struct argp_option opts[] = {
>> @@ -295,6 +303,7 @@ static const struct argp_option opts[] = {
>>            "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
>>          { "top-src-lines", 'S', "N", 0, "Emit N most frequent source code lines" },
>>          { "set-global-vars", 'G', "GLOBAL", 0, "Set global variables provided in the expression, for example \"var1 = 1\"" },
>> +       { "dump", OPT_DUMP, "DUMP_MODE", OPTION_ARG_OPTIONAL, "Print BPF program dump (xlated, jited)" },
>>          {},
>>   };
>>
>> @@ -427,6 +436,16 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>>                          return err;
>>                  }
>>                  break;
>> +       case OPT_DUMP:
>> +               if (!arg || strcasecmp(arg, "xlated") == 0) {
>> +                       env.dump_mode |= DUMP_XLATED;
>> +               } else if (strcasecmp(arg, "jited") == 0) {
>> +                       env.dump_mode |= DUMP_JITED;
>> +               } else {
>> +                       fprintf(stderr, "Unrecognized dump mode '%s'\n", arg);
>> +                       return -EINVAL;
>> +               }
>> +               break;
>>          default:
>>                  return ARGP_ERR_UNKNOWN;
>>          }
>> @@ -1554,6 +1573,49 @@ static int parse_rvalue(const char *val, struct rvalue *rvalue)
>>          return 0;
>>   }
>>
>> +static void dump(__u32 prog_id, enum dump_mode mode, const char *file_name, const char *prog_name)
>> +{
>> +       char command[64], buf[4096];
>> +       ssize_t len, wrote, off;
>> +       FILE *fp;
>> +       int status;
>> +
>> +       status = system("which bpftool > /dev/null 2>&1");
>> +       if (status != 0) {
>> +               fprintf(stderr, "bpftool is not available, can't print program dump\n");
>> +               return;
>> +       }
>> +       snprintf(command, sizeof(command), "bpftool prog dump %s id %u",
>> +                mode == DUMP_JITED ? "jited" : "xlated", prog_id);
>> +       fp = popen(command, "r");
>> +       if (!fp) {
>> +               fprintf(stderr, "Can't run bpftool\n");
> maybe "bpftool failed with error: %d\n" and pass errno?
>
>> +               return;
>> +       }
>> +
>> +       printf("%s/%s DUMP %s:\n", file_name, prog_name, mode == DUMP_JITED ? "JITED" : "XLATED");
>> +       fflush(stdout);
>> +       do {
>> +               len = read(fileno(fp), buf, sizeof(buf));
>> +               if (len < 0)
>> +                       goto error;
>> +
>> +               for (off = 0; off < len;) {
>> +                       wrote = write(STDOUT_FILENO, buf + off, len - off);
>> +                       if (wrote <= 0)
>> +                               goto error;
>> +                       off += wrote;
>> +               }
>> +       } while (len > 0);
>> +       write(STDOUT_FILENO, "\n", 1);
> Given we have FILE abstraction, wouldn't it be more natural to use
> fread()/fwrite()/feof()?
>
> this also doesn't handle interrupted syscalls (-EINTR)
I did that initially, but then removed, is there a relevant scenario 
where veristat handles signals, is it
  SIGSTOP/SIGCONT ? Otherwise it's going to terminate anyway, isn't it?
>
> pw-bot: cr
>
>> +       goto out;
>> +error:
>> +       fprintf(stderr, "Could not write BPF prog dump. Error: %s (errno=%d)\n", strerror(errno),
> why so specific, "write", if it could be an error during reading from
By write I meant "output" or "print" in a sense that we
can't print dump any further, because there is some error.
I'll send the next version.
> bpftool? And note a more or less consistent "Failed to ..." wording,
> there is not a single "Could not" in veristat.c. So something generic
> like "Failed to fetch BPF program dump" or something?
>
>> +               errno);
>> +out:
>> +       pclose(fp);
>> +}
>> +
>>   static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
>>   {
>>          const char *base_filename = basename(strdupa(filename));
>> @@ -1630,8 +1692,13 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>
>>          memset(&info, 0, info_len);
>>          fd = bpf_program__fd(prog);
>> -       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0)
>> +       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0) {
>>                  stats->stats[JITED_SIZE] = info.jited_prog_len;
>> +               if (env.dump_mode & DUMP_JITED)
>> +                       dump(info.id, DUMP_JITED, base_filename, prog_name);
>> +               if (env.dump_mode & DUMP_XLATED)
>> +                       dump(info.id, DUMP_XLATED, base_filename, prog_name);
>> +       }
>>
>>          parse_verif_log(buf, buf_sz, stats);
>>
>> --
>> 2.51.0
>>


