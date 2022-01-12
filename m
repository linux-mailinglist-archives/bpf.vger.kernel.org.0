Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5918048CAB2
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 19:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356113AbiALSKc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 13:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356104AbiALSJk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 13:09:40 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD26C06175D
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 10:08:59 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id o1so6439257uap.4
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 10:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=egAuYV96/47tI4C9f5X3KHl7xh/HY8o5DI+QT+JlASE=;
        b=bHjQ4T3kOl+Lu9Z1ebzzeQDb4zc56gXmDsDIC/cjU9UYjiZe+NmDQclt+E1fA9Jqwv
         5iSwbRjZSzTDbkrnUdoKww4JExOIaSF+FMk2+5KvQJMNI0JuAEuDXpuoyzu1jF1NfMBF
         VbtmGW/GPnKnCMOYyElIitLpvly3ixPSDe3CtcZZhu0Di1M5dDst6wVbtlrISAN8Gi2L
         0eR9NE8C+lDMb6Z2mVoT9oDr61rPhnEAgNV+QLn6NeuHVEhPfLZY8BEjX41Ew8w3YLfX
         sT99JBMXEfRsRSIwp2Yk6rO3dzDQ4NOxlmjlT7yVNzfmIMp+1pUuGOi4/Q48DlvxbgB2
         EJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=egAuYV96/47tI4C9f5X3KHl7xh/HY8o5DI+QT+JlASE=;
        b=mEltO59Du/Z2M5TowkcGJtqJfuRFBCpF1hMXkXIeRA/HvjBP5I+SwX4q9aFMW48zl4
         W4V7N2ZA+7gzSzCCNo7geqwStFrdRxo5OyqPSWYe+hp2SRuxyRHzDUhNR/yj8Q58HQB2
         RQnv0tjnQxal4SVXgiqI5rhZtPAnr/mC2QHYqmRre9CNCQT/u0ulSDyiPucPCvjKnfkl
         qUSvHG+6SOcyZbUSbgw/PGyH+bwuSnCAjdY+NTHvPE6xZEcQuhKBLxy/0V0RUfOZB7Zl
         W1kSzhnlJ+lJpV/j0fLXgUahTBTDQnceIFdNguQFyPe+En5l9/mfv+B3lu72vTGWCZjF
         YMWw==
X-Gm-Message-State: AOAM533nSJ9ctxC0IfuJmtB7Jkd0FsDSjv5FQXYdyfd/hsDd8sqsectE
        armTl6RJQ1gG7Qew0FM+1iK5ag==
X-Google-Smtp-Source: ABdhPJwHL1jPAVe+MNSyXP25viUK8Bhg9ehdck830lgSKgFmAZZdlF2espZTRNiejbhYbYALX2KDww==
X-Received: by 2002:ab0:482a:: with SMTP id b39mr626701uad.110.1642010938437;
        Wed, 12 Jan 2022 10:08:58 -0800 (PST)
Received: from [192.168.1.8] ([149.86.74.57])
        by smtp.gmail.com with ESMTPSA id e71sm256233vke.56.2022.01.12.10.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 10:08:58 -0800 (PST)
Message-ID: <33e77eec-524a-ffb0-9efc-a58da532a578@isovalent.com>
Date:   Wed, 12 Jan 2022 18:08:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next v4 3/8] bpftool: Add gen btf command
Content-Language: en-GB
To:     =?UTF-8?Q?Mauricio_V=c3=a1squez?= <mauricio@kinvolk.io>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
References: <20220112142709.102423-1-mauricio@kinvolk.io>
 <20220112142709.102423-4-mauricio@kinvolk.io>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220112142709.102423-4-mauricio@kinvolk.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-12 09:27 UTC-0500 ~ Mauricio Vásquez <mauricio@kinvolk.io>
> This command is implemented under the "gen" command in bpftool and the
> syntax is the following:
> 
> $ bpftool gen btf INPUT OUTPUT OBJECT(S)

Thanks a lot for this work!

Please update the relevant manual page under Documentation, to let users
know how to use the feature. You may also consider adding an example at
the end of that document.

The bash completion script should also be updated with the new "btf"
subcommand for "gen". Given that all the arguments are directories and
files, it should not be hard.

Have you considered adding tests for the feature? There are a few
bpftool-related selftests under tools/testing/selftests/bpf/.

> 
> INPUT can be either a single BTF file or a folder containing BTF files,
> when it's a folder, a BTF file is generated for each BTF file contained
> in this folder. OUTPUT is the file (or folder) where generated files are
> stored and OBJECT(S) is the list of bpf objects we want to generate the
> BTF file(s) for (each generated BTF file contains all the types needed
> by all the objects).
> 
> Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
> Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
> Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
> ---
>  tools/bpf/bpftool/gen.c | 117 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 43e3f8700ecc..cdeb1047d79d 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -5,6 +5,7 @@
>  #define _GNU_SOURCE
>  #endif
>  #include <ctype.h>
> +#include <dirent.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/err.h>
> @@ -1084,6 +1085,7 @@ static int do_help(int argc, char **argv)
>  	fprintf(stderr,
>  		"Usage: %1$s %2$s object OUTPUT_FILE INPUT_FILE [INPUT_FILE...]\n"
>  		"       %1$s %2$s skeleton FILE [name OBJECT_NAME]\n"
> +		"       %1$s %2$s btf INPUT OUTPUT OBJECT(S)\n"
>  		"       %1$s %2$s help\n"
>  		"\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"
> @@ -1094,9 +1096,124 @@ static int do_help(int argc, char **argv)
>  	return 0;
>  }
>  
> +/* Create BTF file for a set of BPF objects */
> +static int btfgen(const char *src_btf, const char *dst_btf, const char *objspaths[])
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int is_file(const char *path)
> +{
> +	struct stat st;
> +
> +	if (stat(path, &st) < 0)
> +		return -1;
> +
> +	switch (st.st_mode & S_IFMT) {
> +	case S_IFDIR:
> +		return 0;
> +	case S_IFREG:
> +		return 1;
> +	default:
> +		return -1;
> +	}
> +}
> +
> +static int do_gen_btf(int argc, char **argv)
> +{
> +	char src_btf_path[PATH_MAX], dst_btf_path[PATH_MAX];
> +	bool input_is_file, output_is_file = false;
> +	const char *input, *output;
> +	const char **objs = NULL;
> +	struct dirent *dir;
> +	DIR *d = NULL;
> +	int i, err;
> +
> +	if (!REQ_ARGS(3)) {
> +		usage();
> +		return -1;
> +	}
> +
> +	input = GET_ARG();
> +	err = is_file(input);
> +	if (err < 0) {
> +		p_err("failed to stat %s: %s", input, strerror(errno));
> +		return err;
> +	}
> +	input_is_file = err;
> +
> +	output = GET_ARG();
> +	err = is_file(output);
> +	if (err != 0)
> +		output_is_file = true;

Why not return if err < 0? This will set output_is_file to true and will
fail later, I think?

> +
> +	objs = (const char **) malloc((argc + 1) * sizeof(*objs));
> +	if (!objs)
> +		return -ENOMEM;

Let's p_err() a message.

> +
> +	i = 0;
> +	while (argc > 0)
> +		objs[i++] = GET_ARG();
> +
> +	objs[i] = NULL;
> +
> +	/* single BTF file */
> +	if (input_is_file) {
> +		printf("SBTF: %s\n", input);

We can use "p_info()" instead of "printf()". In particular, this avoids
printing the message when the JSON output is required.

> +
> +		if (output_is_file) {
> +			err = btfgen(input, output, objs);
> +			goto out;
> +		}
> +		snprintf(dst_btf_path, sizeof(dst_btf_path), "%s/%s", output,
> +			 basename(input));

Am I right that the output file should be just a file name, and not a
path, and that it will be created under the same directory as the input
file? And that providing a relative or absolute path instead will cause
issues here? If so, please document it. It would be nice to be able to
support paths too, but I'm not sure how much work that represents.

> +		err = btfgen(input, dst_btf_path, objs);
> +		goto out;
> +	}
> +
> +	if (output_is_file) {
> +		p_err("can't have just one file as output");

See comment above, this message is misleading if stat() returned with an
error.

> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* directory with BTF files */
> +	d = opendir(input);
> +	if (!d) {
> +		p_err("error opening input dir: %s", strerror(errno));
> +		err = -errno;
> +		goto out;
> +	}
> +
> +	while ((dir = readdir(d)) != NULL) {
> +		if (dir->d_type != DT_REG)
> +			continue;
> +
> +		if (strncmp(dir->d_name + strlen(dir->d_name) - 4, ".btf", 4))
> +			continue;
> +
> +		snprintf(src_btf_path, sizeof(src_btf_path), "%s/%s", input, dir->d_name);
> +		snprintf(dst_btf_path, sizeof(dst_btf_path), "%s/%s", output, dir->d_name);
> +
> +		printf("SBTF: %s\n", src_btf_path);
> +
> +		err = btfgen(src_btf_path, dst_btf_path, objs);
> +		if (err)
> +			goto out;
> +	}
> +
> +out:
> +	if (!err)
> +		printf("STAT: done!\n");

p_info()

> +	free(objs);
> +	closedir(d);

If input is a single file, "d" will not be a valid directory stream
descriptor, and I expect closedir() to fail and set errno even if
everything else went fine. The return code does not matter, but "errno
!= 0" may cause bpftool's batch mode to error out. Can you please run
closedir() only "if (d)"?

> +	return err;
> +}
> +
>  static const struct cmd cmds[] = {
>  	{ "object",	do_object },
>  	{ "skeleton",	do_skeleton },
> +	{ "btf",	do_gen_btf},
>  	{ "help",	do_help },
>  	{ 0 }
>  };

