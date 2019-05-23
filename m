Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1927340
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 02:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfEWA0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 20:26:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43731 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWA0A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 20:26:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id i26so4705115qtr.10
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 17:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=p2ctVWfsWv4UZmWXJa4C4BH8ZDcP+z9l9tCHrEYfKWs=;
        b=OitvanUGiiqrHHT0P9oMZuKu1AccSFRObmHJg2YUzT9+LsJIedb4PXPSu4mmji3eH4
         M5OZNYTTkSmpt6Gk1sjycNNCk80eev381T2M7VKFbxp3GvQHpfb5e5/I/iaSyS/ivpuR
         ZPQpknEEeW+651kcEWtkUxBOdlwn7LkKkYMIeLdcsOEFTj7kpTVXPYi4TQgk3O10hEzn
         pjhzKHO+k8ZK3GzoiIzPj9fZmOsT3QS+5iVlaROYq8L9+eIAkZmB6VsiD+xYK5icucbh
         VYVdn/sBJ7BTLurnWuTF6D+y9PG3g1lA83PqrtIeflCJgYBvGJC3RGulUM6rvdO9eaRY
         PuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=p2ctVWfsWv4UZmWXJa4C4BH8ZDcP+z9l9tCHrEYfKWs=;
        b=kTuCGUy7Dktu3L6aGc2oITnRl7KHhwtTh1mU1+NWZgA88WPhHHxXHP6BzhTjHHGyB4
         Zefmt9FabpvNJmhYi7fN29AVQ8V/YeFK0JK2oGGUcJHws5TM5whoqv8Ydd8LIt9g1WLC
         BexYr0wpjJCOaPJTXoG1leJrI1d+WPNEoKhBOAN1Xu9wQ5wKYeI0Ot0lcTxMEqMhPh1O
         WqOBZ7XYgTYHeBmEG3eD/dlpffb0aEZsTucwWXWMHVp3xud98vS0VzEV8LoSN5fcGf+8
         ayBnwNREAiWxLfXhDixSUmfRkZdF4Pcgll8UxeuHn0r7NowS+K0+MF+LSztjd3MvKJxn
         JXJQ==
X-Gm-Message-State: APjAAAWL3u3AJoWBx5H9UX8XS+ZiZxuMHmWViiBZlh4LTVvO+EJ4qkRH
        d8hBBGCSwSdJO2h4ikDVzJeO0g==
X-Google-Smtp-Source: APXvYqxQyiEw/5ykorGvcpYrM2rQavIzorIE5QiQIdIDqGsI118wqz/vFBy0tbLXT5OXPrgNIbo1bg==
X-Received: by 2002:ac8:1af9:: with SMTP id h54mr75912436qtk.292.1558571158974;
        Wed, 22 May 2019 17:25:58 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m30sm6610421qtf.77.2019.05.22.17.25.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 17:25:58 -0700 (PDT)
Date:   Wed, 22 May 2019 17:25:53 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 10/12] bpftool: add C output format option to
 btf dump subcommand
Message-ID: <20190522172553.6f057e51@cakuba.netronome.com>
In-Reply-To: <20190522195053.4017624-11-andriin@fb.com>
References: <20190522195053.4017624-1-andriin@fb.com>
        <20190522195053.4017624-11-andriin@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 May 2019 12:50:51 -0700, Andrii Nakryiko wrote:
> Utilize new libbpf's btf_dump API to emit BTF as a C definitions.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/bpf/bpftool/btf.c | 63 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index a22ef6587ebe..ed3d3221cc78 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -1,5 +1,12 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -/* Copyright (C) 2019 Facebook */
> +
> +/*
> + * BTF dumping command.
> + * Load BTF from multiple possible sources and outptu entirety or subset of
> + * types in either raw format or C-syntax format.
> + *

I don't think this header adds any value.  Its very unlikely people
will remember to update it.  And it's misspelled to begin with.
Please remove.

> + * Copyright (C) 2019 Facebook
> + */
>  
>  #include <errno.h>
>  #include <fcntl.h>
> @@ -340,11 +347,48 @@ static int dump_btf_raw(const struct btf *btf,
>  	return 0;
>  }
>  
> +static void btf_dump_printf(void *ctx, const char *fmt, va_list args)
> +{
> +	vfprintf(stdout, fmt, args);
> +}
> +
> +static int dump_btf_c(const struct btf *btf,
> +		      __u32 *root_type_ids, int root_type_cnt)

Please break the line after static int.

> +{
> +	struct btf_dump *d;
> +	int err = 0, i, id;

Hmm.. why do you have both i and id here?  Maybe my eyes are failing me
but it seems either one or the other is used in different branches of
the main if () :)

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
> +		for (id = 1; id <= cnt; id++) {
> +			err = btf_dump__dump_type(d, id);
> +			if (err)
> +				goto done;
> +		}
> +	}
> +
> +done:
> +	btf_dump__free(d);
> +	return err;

What do we do for JSON output?

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
> @@ -431,6 +475,16 @@ static int do_dump(int argc, char **argv)
>  		goto done;
>  	}
>  
> +	while (argc) {
> +		if (strcmp(*argv, "c") == 0) {
> +			dump_c = true;
> +			NEXT_ARG();
> +		} else {
> +			p_err("unrecognized option: '%s'", *argv);
> +			goto done;
> +		}
> +	}

This code should have checked there are no arguments and return an
error from the start :S

>  	if (!btf) {
>  		err = btf__get_from_id(btf_id, &btf);
>  		if (err) {
> @@ -444,7 +498,10 @@ static int do_dump(int argc, char **argv)
>  		}
>  	}
>  
> -	dump_btf_raw(btf, root_type_ids, root_type_cnt);
> +	if (dump_c)
> +		dump_btf_c(btf, root_type_ids, root_type_cnt);
> +	else
> +		dump_btf_raw(btf, root_type_ids, root_type_cnt);
>  
>  done:
>  	close(fd);
> @@ -460,7 +517,7 @@ static int do_help(int argc, char **argv)
>  	}
>  
>  	fprintf(stderr,
> -		"Usage: %s btf dump BTF_SRC\n"
> +		"Usage: %s btf dump BTF_SRC [c]\n"

bpftool generally uses <key value> formats.  So perhaps we could do
something like "[format raw|c]" here for consistency, defaulting to raw?

>  		"       %s btf help\n"
>  		"\n"
>  		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"

