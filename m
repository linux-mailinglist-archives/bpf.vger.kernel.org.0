Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432025A15C3
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbiHYP36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiHYP3k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 11:29:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24284E637
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 08:28:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k9so25100510wri.0
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=0rKzFaEWDpDjc2j0jc2K5Ynwo5OVYphvFdMA9NbZ3+8=;
        b=QouNjKEsowy6HJVzGrkJsTgx+GAQa/c6qDeJdnbsLPw5Hu+0ehgwGmHVwZVZOthgyU
         ArA/fehGPi8AHtlC94X3+fhhnQRF/i0EYDAP2+R1F7SUSmHJdP/YoYoTIhRvJOlvNyJr
         WMRa1E5WPxpjFKy12h6FQic8QS/DXPyKLVz+xOsu5oK7TKQ2CE3S+5iJywlz97FEai8Z
         PfidK01GSb650xmjeOpm7FZPuxIldC4tkKSjmgZv8Jyj5KN1cm02D+6tOhlSH6Qrs5Zg
         nlO7v9sB9SCrydT5SJo6H3nsm87UFIecbgw5SXLbCJ9uzX6Sx59xUPOt+3BEyV6c+3iF
         RN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0rKzFaEWDpDjc2j0jc2K5Ynwo5OVYphvFdMA9NbZ3+8=;
        b=xWqnAcH8BKSy6GplWNmhXelS4QC04rCK3Q7Ee2+AkTiHhaFtYeTVN0UDd1DD519C//
         nOEUou8qeoYognoKJ3jqDM+OeU/4xTKPzDRrjh5DYG1jXrTQck0wd18KL7N9pVU3/HKJ
         VScDj/PCWVe57iOsoc8Q+KiV5CQX1Le5gJ68/4tLRwzuhkTsQzT6mJ4IZDqEZ7nC+w/R
         Jd8omc6xHD7cX7p0NdxS4uPQn5vi/I8DrFCTtelqShT7Wz+TSyWIQPwB7PAWA5Ar5kRe
         wnvwhuNLz5pZfHslFDHfbasyC1b416Dy3YMhMk+8qMA7CS0DRtgZyTS49T84WAlxCAWU
         JrBg==
X-Gm-Message-State: ACgBeo2xvqSTbhFQ8TMK8aIKUFsFqqDRKB3h514qCO7Akiii4rdTvAbt
        eVBKi7Cy9Rr4RcepfLy6Ns4t+w==
X-Google-Smtp-Source: AA6agR5tDxcL2OTFiXn3ggEPd3EJGdw/eYqx74N6LygBXETuKk9Eb7K7Hr1jRwm+OrI7bBMGM9xEqA==
X-Received: by 2002:a05:6000:12c3:b0:225:3063:82a6 with SMTP id l3-20020a05600012c300b00225306382a6mr2562068wrx.541.1661441329319;
        Thu, 25 Aug 2022 08:28:49 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id cc19-20020a5d5c13000000b0022571d43d32sm5111263wrb.21.2022.08.25.08.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 08:28:48 -0700 (PDT)
Message-ID: <b942bf8f-204b-6bf1-7847-ec5f11c50ca0@isovalent.com>
Date:   Thu, 25 Aug 2022 16:28:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next v2] bpftool: implement perf attach command
Content-Language: en-GB
To:     Wei Yongjun <weiyongjun1@huawei.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220824033837.458197-1-weiyongjun1@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220824033837.458197-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Wei,

Apologies for failing to answer to your previous email and for the delay
on this one, I just found out GMail had classified them as spam :(.

So as for your last message, yes: your understanding of my previous
answer was correct. Thanks for the patch below! Some comments inline.

On 24/08/2022 04:38, Wei Yongjun wrote:
> This patch introduces a new bpftool command: perf attach,
> which used to attaching/pinning tracepoints programs.
> 
>   bpftool perf attach PROG TP_NAME FILE
> 
> It will attach bpf program PROG to tracepoint TP_NAME and
> pin tracepoint program as FILE, FILE must be located in
> bpffs mount.
> 
> For example,
>   $ bpftool prog load mtd-mchp23k256.o /sys/fs/bpf/test_prog
> 
>   $ bpftool prog
>   510: raw_tracepoint_writable  name mtd_mchp23k256  tag 2e13281b1f781bf3  gpl
>         loaded_at 2022-08-24T02:50:06+0000  uid 0
>         xlated 960B  not jited  memlock 4096B  map_ids 439,437,440
>         btf_id 740
>   $ bpftool perf attach id 510 spi_transfer_writeable /sys/fs/bpf/test_perf

How would you feel about adding more keywords to this syntax?

    $ bpftool perf attach id 510 attach_name <spi_...> path /sys/...

A bit more parsing to do, but it's more flexible if we need or want more
arguments in the future. We don't have to accept them in any random
order, fixed order is fine (but having keywords allow us to support
random order in the future).

> 
>   $ bpftool link show
>   74: raw_tracepoint  prog 510
>         tp 'spi_transfer_writeable'
> 
> The implementation a BPF based backend for mchp23k256 mtd mockup
> device.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v1 -> v2: switch to extend perf command instead add new one
> v1: https://patchwork.kernel.org/project/netdevbpf/patch/20220816151725.153343-1-weiyongjun1@huawei.com/
> ---
>  .../bpftool/Documentation/bpftool-perf.rst    | 11 ++-
>  tools/bpf/bpftool/perf.c                      | 67 ++++++++++++++++++-
>  2 files changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-perf.rst b/tools/bpf/bpftool/Documentation/bpftool-perf.rst
> index 5fea633a82f1..085c8dcfb9aa 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-perf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-perf.rst
> @@ -19,12 +19,13 @@ SYNOPSIS
>  	*OPTIONS* := { |COMMON_OPTIONS| }
>  
>  	*COMMANDS* :=
> -	{ **show** | **list** | **help** }
> +	{ **show** | **list** | **help** | **attach** }

Missing (see bpftool-prog.rst):

    |	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag**
*PROG_TAG* | **name** *PROG_NAME* }


>  
>  PERF COMMANDS
>  =============
>  
>  |	**bpftool** **perf** { **show** | **list** }
> +|	**bpftool** **perf** **attach** *PROG* *TP_NAME* *FILE*

Please rename TP_NAME into something else (here and below), maybe
ATTACH_NAME or ATTACH_POINT, because we may support some other types in
the future.

>  |	**bpftool** **perf help**
>  
>  DESCRIPTION
> @@ -39,6 +40,14 @@ DESCRIPTION
>  		  or a kernel virtual address.
>  		  The attachment point for u[ret]probe is the file name and the file offset.
>  
> +	**bpftool perf attach PROG TP_NAME FILE**
> +		  Attach bpf program *PROG* to tracepoint *TP_NAME* and pin
> +		  program *PROG* as *FILE*.

Could you please add two notes on 1) how to detach the program (by
deleting the link with rm, or does "bpftool link detach" work?), and 2)
raw tracepoints (+ writable version) currently being the only supported
program types for this command?

> +
> +		  Note: *FILE* must be located in *bpffs* mount. It must not
> +		  contain a dot character ('.'), which is reserved for future
> +		  extensions of *bpffs*.

Note: It's not really future extensions anymore, but other parts of the
docs say that, so let's keep this and we'll clean up everywhere at some
point.

> +
>  	**bpftool perf help**
>  		  Print short help message.
>  
> diff --git a/tools/bpf/bpftool/perf.c b/tools/bpf/bpftool/perf.c
> index 226ec2c39052..9149ba960784 100644
> --- a/tools/bpf/bpftool/perf.c
> +++ b/tools/bpf/bpftool/perf.c
> @@ -233,8 +233,9 @@ static int do_show(int argc, char **argv)
>  static int do_help(int argc, char **argv)
>  {
>  	fprintf(stderr,
> -		"Usage: %1$s %2$s { show | list }\n"
> +		"Usage: %1$s %2$s { show | list | attach }\n"
>  		"       %1$s %2$s help }\n"
> +		"       %1$s %2$s attach PROG TP_NAME FILE\n"

Should be:

		"Usage: %1$s %2$s { show | list }\n"
		"       %1$s %2$s attach PROG ATTACH_NAME FILE\n"
 		"       %1$s %2$s help }\n"

No need to list the subcommand twice, and let's keep "help" at the end.

>  		"\n"
>  		"       " HELP_SPEC_OPTIONS " }\n"
>  		"",
> @@ -243,10 +244,74 @@ static int do_help(int argc, char **argv)
>  	return 0;
>  }
>  
> +static enum bpf_prog_type get_prog_type(int progfd)
> +{
> +	struct bpf_prog_info info = {};
> +	__u32 len = sizeof(info);
> +
> +	if (bpf_obj_get_info_by_fd(progfd, &info, &len))
> +		return BPF_PROG_TYPE_UNSPEC;
> +
> +	return info.type;
> +}
> +
> +static int do_attach(int argc, char **argv)
> +{
> +	enum bpf_prog_type prog_type;
> +	char *tp_name, *path;
> +	int err, progfd, pfd;

pfd -> pinfd?

> +
> +	if (!REQ_ARGS(4))
> +		return -EINVAL;
> +
> +	progfd = prog_parse_fd(&argc, &argv);
> +	if (progfd < 0)
> +		return progfd;
> +
> +	if (!REQ_ARGS(2)) {
> +		err = -EINVAL;
> +		goto out_close;
> +	}
> +
> +	tp_name = GET_ARG();
> +	path = GET_ARG();
> +
> +	prog_type = get_prog_type(progfd);
> +	switch (prog_type) {
> +	case BPF_PROG_TYPE_RAW_TRACEPOINT:
> +	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
> +		pfd = bpf_raw_tracepoint_open(tp_name, progfd);
> +		if (pfd < 0) {
> +			printf("failed to attach to raw tracepoint '%s'\n",
> +			       tp_name);

This should go to stderr. Please use:

    p_err("failed to attach to raw tracepoint '%s'", tp_name);

(No line break needed.)

> +			err = pfd;
> +			goto out_close;
> +		}
> +		break;
> +	default:
> +		printf("invalid program type %s\n",
> +		       libbpf_bpf_prog_type_str(prog_type));

p_err(). Also we could maybe mentioned that raw_tracepoint is the only
type supported?

> +		err = -EINVAL;
> +		goto out_close;
> +	}
> +
> +	err = do_pin_fd(pfd, path);
> +	if (err) {
> +		close(pfd);
> +		goto out_close;
> +	}
> +
> +	return 0;

No need for the last error check here. Initialise err to 0, then close
pfd unconditionally and just go through out_close to close progfd then
return err. Once the link is pinned, it's OK to close the file
descriptors. They will close anyway when bpftool exits.

> +
> +out_close:

"out_close" indeed, but the close(progfd) is missing :)

> +	return err;
> +}

Nitpick: I'd rather have do_attach() defined before do_help() in the
file. That's probably just me being used to look for the usage strings
at the bottom of most bpftool files.

> +
>  static const struct cmd cmds[] = {
>  	{ "show",	do_show },
>  	{ "list",	do_show },
>  	{ "help",	do_help },
> +	{ "attach",	do_attach },
>  	{ 0 }
>  };
>  

Please add the related bash completion in
.../bpftool/bash-completion/bpftool. It should look like this:

diff --git a/tools/bpf/bpftool/bash-completion/bpftool
b/tools/bpf/bpftool/bash-completion/bpftool
index dc1641e3670e..dd8d424e9a59 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -1080,10 +1080,37 @@ _bpftool()
             ;;
         perf)
             case $command in
+                attach)
+                    local PROG_TYPE='id pinned tag name'
+                    case $cword in
+                        3)
+                            COMPREPLY=( $( compgen -W "$PROG_TYPE" --
"$cur" ) )
+                            return 0
+                            ;;
+                        4)
+                            case $prev in
+                                id)
+                                    _bpftool_get_prog_ids
+                                    ;;
+                                name)
+                                    _bpftool_get_prog_names
+                                    ;;
+                            esac
+                            return 0
+                            ;;
+                        5) # Attach type
+                            return 0
+                            ;;
+                        6) # Pinned link path
+                            _filedir
+                            return 0
+                            ;;
+                    esac
+                    ;;
                 *)
                     [[ $prev == $object ]] && \
                         COMPREPLY=( $( compgen -W 'help \
-                            show list' -- "$cur" ) )
+                            show list attach' -- "$cur" ) )
                     ;;
             esac
             ;;

