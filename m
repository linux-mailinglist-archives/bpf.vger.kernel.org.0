Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFE92944C
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389745AbfEXJOD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 05:14:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33672 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389690AbfEXJOD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 05:14:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so9212092wrx.0
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RVyNKOVt/EDGtTx6flclwysXbFv+GBmE5TT4j3sW4NE=;
        b=sPvQUKah7KvdTV9VnrbgB3U4s7Zv3heVClibO4EQkv7YuQ7aeJiji0m3BgP9PZwkd6
         ROdH2f71/rY5IvDB/UzqROC4/vwyxwNLHsboIehDvm7Ofy9eo3B329v5CoWE64wanP4l
         QcymLLAaIjbobUbTxYWppEeauhudujD+ElNDGbKhSzSEFJp1uz2ispXwlzOYO6jVF/7b
         IzFUeUmhcuVva/b4KePM+GK9QlHoFQVvKiZ05NMXm1dVDN0bq90mFCwMV21JVKpb9bP+
         DAzLA2agLXbxTj1uOSU4GEeUz/xZS46LoQBTE71ZShMZ4g//7CQOlgsWHTEvlxfgdCgw
         szCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RVyNKOVt/EDGtTx6flclwysXbFv+GBmE5TT4j3sW4NE=;
        b=h0mcFEMYQptH0F7QnmOudONFkds23IpbU1EjtpCEcq9nAxVLIb1lfl6CyFo9rwVNf4
         uQN0NOc3j0I952MP8ouVAAWIdjUcBl+quIQY6ak3LPWUhpgXyOuS96YzSFdw5vjmn2nM
         Uu42m4lhopgXpg0do4m8Gfhr7em4tC7l7FucpSPZiytIUIqpK7mCtwNXrBPSoWkezV5W
         Qsdfo6VYGvGe4FxD+LXOU2pkx/jilHsFga6zf73e6mpDpfRod/a9USi6prnBxxEGB6pi
         p2t8cQV992VqOuVDTfXSHQR5DTvdBxXZc0lxz6blKNobQA1Z0Ol7USatDPk25ypfTvNC
         GbMw==
X-Gm-Message-State: APjAAAWcOyfC4C7ub2Vq9N3zujn3iyPYVXWQdKSHpIzN9rpmKvpRaKvT
        N2DIVyTA7PLIzDx/W4Aw7zcMmQ==
X-Google-Smtp-Source: APXvYqyunrGNj9PV/AL0GvIyehpLXsHRaC7JaZkKj0sb0carin2AgfWSg5X6FnyRTZ9Ta67mdFGT0A==
X-Received: by 2002:adf:fa88:: with SMTP id h8mr11675952wrr.32.1558689240982;
        Fri, 24 May 2019 02:14:00 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id 34sm4111036wre.32.2019.05.24.02.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:14:00 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 10/12] bpftool: add C output format option to
 btf dump subcommand
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, kernel-team@fb.com
References: <20190523204222.3998365-1-andriin@fb.com>
 <20190523204222.3998365-11-andriin@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <eb690c2d-14d4-9c6f-2138-44f8cd027860@netronome.com>
Date:   Fri, 24 May 2019 10:13:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523204222.3998365-11-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

Some nits inline, nothing blocking though.

2019-05-23 13:42 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Utilize new libbpf's btf_dump API to emit BTF as a C definitions.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/bpf/bpftool/btf.c | 74 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index a22ef6587ebe..1cdbfad42b38 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -340,11 +340,48 @@ static int dump_btf_raw(const struct btf *btf,
>  	return 0;
>  }
>  
> +static void btf_dump_printf(void *ctx, const char *fmt, va_list args)

Nit: This function could have a printf attribute ("__printf(2, 0)").

> +{
> +	vfprintf(stdout, fmt, args);
> +}
> +
> +static int dump_btf_c(const struct btf *btf,
> +		      __u32 *root_type_ids, int root_type_cnt)
> +{
> +	struct btf_dump *d;
> +	int err = 0, i;
> +
> +	d = btf_dump__new(btf, NULL, NULL, btf_dump_printf);
> +	if (IS_ERR(d))
> +		return PTR_ERR(d);
> +
> +	if (root_type_cnt) {
> +		for (i = 0; i < root_type_cnt; i++) {
> +			err = btf_dump__dump_type(d, root_type_ids[i]);
> +			if (err)
> +				goto done;
> +		}
> +	} else {
> +		int cnt = btf__get_nr_types(btf);
> +
> +		for (i = 1; i <= cnt; i++) {
> +			err = btf_dump__dump_type(d, i);
> +			if (err)
> +				goto done;
> +		}
> +	}
> +
> +done:
> +	btf_dump__free(d);
> +	return err;
> +}
> +
>  static int do_dump(int argc, char **argv)
>  {
>  	struct btf *btf = NULL;
>  	__u32 root_type_ids[2];
>  	int root_type_cnt = 0;
> +	bool dump_c = false;
>  	__u32 btf_id = -1;
>  	const char *src;
>  	int fd = -1;
> @@ -431,6 +468,29 @@ static int do_dump(int argc, char **argv)
>  		goto done;
>  	}
>  
> +	while (argc) {
> +		if (is_prefix(*argv, "format")) {
> +			NEXT_ARG();
> +			if (argc < 1) {
> +				p_err("expecting value for 'format' option\n");
> +				goto done;
> +			}
> +			if (strcmp(*argv, "c") == 0) {
> +				dump_c = true;
> +			} else if (strcmp(*argv, "raw") == 0) {

Do you think we could use is_prefix() instead of strcmp() here?

> +				dump_c = false;
> +			} else {
> +				p_err("unrecognized format specifier: '%s'",
> +				      *argv);

Would it be worth reminding the user about the valid specifiers in that
message? (But then we already have it in do_help(), so maybe not.)

> +				goto done;
> +			}
> +			NEXT_ARG();
> +		} else {
> +			p_err("unrecognized option: '%s'", *argv);
> +			goto done;
> +		}
> +	}
> +
>  	if (!btf) {
>  		err = btf__get_from_id(btf_id, &btf);
>  		if (err) {
> @@ -444,7 +504,16 @@ static int do_dump(int argc, char **argv)
>  		}
>  	}
>  
> -	dump_btf_raw(btf, root_type_ids, root_type_cnt);
> +	if (dump_c) {
> +		if (json_output) {
> +			p_err("JSON output for C-syntax dump is not supported");
> +			err = -ENOTSUP;
> +			goto done;
> +		}
> +		err = dump_btf_c(btf, root_type_ids, root_type_cnt);
> +	} else {
> +		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
> +	}
>  
>  done:
>  	close(fd);
> @@ -460,10 +529,11 @@ static int do_help(int argc, char **argv)
>  	}
>  
>  	fprintf(stderr,
> -		"Usage: %s btf dump BTF_SRC\n"
> +		"Usage: %s btf dump BTF_SRC [format FORMAT]\n"
>  		"       %s btf help\n"
>  		"\n"
>  		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
> +		"       FORMAT  := { raw | c }\n"
>  		"       " HELP_SPEC_MAP "\n"
>  		"       " HELP_SPEC_PROGRAM "\n"
>  		"       " HELP_SPEC_OPTIONS "\n"
> 

