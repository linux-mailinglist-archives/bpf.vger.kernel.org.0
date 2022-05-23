Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A889530F5C
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 15:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiEWLsO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiEWLsN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 07:48:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9D54CD74
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 04:48:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so21014920wrc.0
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RZqAt1UxLNuxuD4jJfcp3vCq7clbsJTMAPOH3gwAb/U=;
        b=fW8bpfqHzJ+tyCfD4X5iWGuyWGiYWYf1Z4NjrE2FdxGuw9851NURXKNL0yvCjac4Ki
         ql79R+j6ercM9o4lRSVFDRLtCm8SI3TUL5piJfLkXKrSlqd1igxEWjITaGKTrNY4yTP7
         0UqIj00Qr+Q65airM4mikQA6CqDLMXS9sfLxJIGAt8AMfC+yLQGHkOQQGjewBLh79QGf
         EF0r2SxwtDa/xmfniINWgj7d1ghxlGN8b83S0QLBa7wpzisMZrrMsgU9gGJ/4NU3IPCs
         g4cTaR20Zi3mWySnIsbD9TbMjiSF0Ojm+nYxG3wrq5ySYzpD5RPRZSeVwRNM2i/9AjaA
         WIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RZqAt1UxLNuxuD4jJfcp3vCq7clbsJTMAPOH3gwAb/U=;
        b=TjRJluo0atrFhSJc7lPzoz+YXupE3dPLCyQ8EoDEDxUORWEYDkxbMMglc6mNsglKDw
         qmfFVL54qqChAA8Mir1jkNdHSGytWA+m0zolU4mujXI6XXndHudgZc3AQT2eF8ZJZ+Bg
         AfxtGmn+BGUWa0I1wy2DC1Y0rll5GN9U3sGSCIXKyuiwZ4fOtBNuqRqsa9oWdhQ5geG9
         2zyRV7RxSsUxDpK3bQISxSisPr4hXkeFWZdmpa2pSyGp6gMxdzVXIiM8u9yKnxNLJxDy
         95/p4ATRsxc3HlrHKKSE2xVmwxJR7EDD3WHpXI0fPZVsPT5rifpDxy+4B9AGYYCtE00y
         n9qQ==
X-Gm-Message-State: AOAM531oJSHkaRgATmXsZ5bubpMn8Cdif9SqdPuMyWkacGathaNVpwF+
        bk+6d0bb+YArHV7KZp5ECOCztr239SWyizq1RQY=
X-Google-Smtp-Source: ABdhPJyLmcsRLDaoFWtfznxXiLjE7S2w5EF0eDToZg5DY0n7FFMcUI5YGASx+M8GCaT/t+s1AVNoDw==
X-Received: by 2002:a5d:4492:0:b0:20d:740:beb9 with SMTP id j18-20020a5d4492000000b0020d0740beb9mr18512071wrq.179.1653306491109;
        Mon, 23 May 2022 04:48:11 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id d10-20020adfc80a000000b0020fded972c0sm3354512wrh.45.2022.05.23.04.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 04:48:10 -0700 (PDT)
Message-ID: <83796c5c-bb91-bfd0-b02d-e99fa5117a61@isovalent.com>
Date:   Mon, 23 May 2022 12:48:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v3 09/12] bpftool: Use libbpf_bpf_attach_type_str
Content-Language: en-GB
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com
References: <20220519213001.729261-1-deso@posteo.net>
 <20220519213001.729261-10-deso@posteo.net>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220519213001.729261-10-deso@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-05-19 21:29 UTC+0000 ~ Daniel Müller <deso@posteo.net>
> This change switches bpftool over to using the recently introduced
> libbpf_bpf_attach_type_str function instead of maintaining its own
> string representation for the bpf_attach_type enum.
> 
> Note that contrary to other enum types, the variant names that bpftool
> maps bpf_attach_type to do not follow a simple to follow rule. With
> bpf_prog_type, for example, the textual representation can easily be
> inferred by stripping the BPF_PROG_TYPE_ prefix and lowercasing the
> remaining string. bpf_attach_type violates this rule for various
> variants.
> We decided to fix up this deficiency with this change, meaning that
> bpftool uses the same textual representations as libbpf. Supporting
> test, completion scripts, and man pages have been adjusted accordingly.
> However, we did add support for accepting (the now undocumented)
> original attach type names when they are provided by users.
> 
> For the test (test_bpftool_synctypes.py), I have removed the enum
> representation checks, because we no longer mirror the various enum
> variant names in bpftool source code. For the man page, help text, and
> completion script checks we are now using enum definitions from
> uapi/linux/bpf.h as the source of truth directly.
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>
> ---
>  .../bpftool/Documentation/bpftool-cgroup.rst  |  16 +-
>  .../bpftool/Documentation/bpftool-prog.rst    |   5 +-
>  tools/bpf/bpftool/bash-completion/bpftool     |  18 +-
>  tools/bpf/bpftool/cgroup.c                    |  49 ++++--
>  tools/bpf/bpftool/common.c                    |  82 ++++-----
>  tools/bpf/bpftool/link.c                      |  15 +-
>  tools/bpf/bpftool/main.h                      |  17 ++
>  tools/bpf/bpftool/prog.c                      |  26 ++-
>  .../selftests/bpf/test_bpftool_synctypes.py   | 163 ++++++++----------
>  9 files changed, 213 insertions(+), 178 deletions(-)

> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index effe136..c111a5 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -21,25 +21,39 @@
>  #define HELP_SPEC_ATTACH_FLAGS						\
>  	"ATTACH_FLAGS := { multi | override }"
>  
> -#define HELP_SPEC_ATTACH_TYPES						       \
> -	"       ATTACH_TYPE := { ingress | egress | sock_create |\n"	       \
> -	"                        sock_ops | device | bind4 | bind6 |\n"	       \
> -	"                        post_bind4 | post_bind6 | connect4 |\n"       \
> -	"                        connect6 | getpeername4 | getpeername6 |\n"   \
> -	"                        getsockname4 | getsockname6 | sendmsg4 |\n"   \
> -	"                        sendmsg6 | recvmsg4 | recvmsg6 |\n"           \
> -	"                        sysctl | getsockopt | setsockopt |\n"	       \
> -	"                        sock_release }"
> +#define HELP_SPEC_ATTACH_TYPES						\
> +	"       ATTACH_TYPE := { cgroup_inet_ingress | cgroup_inet_egress |\n" \
> +	"                        cgroup_inet_sock_create | cgroup_sock_ops |\n" \
> +	"                        cgroup_device | cgroup_inet4_bind |\n" \
> +	"                        cgroup_inet6_bind | cgroup_inet4_post_bind |\n" \
> +	"                        cgroup_inet6_post_bind | cgroup_inet4_connect |\n" \
> +	"                        cgroup_inet6_connect | cgroup_inet4_getpeername |\n" \
> +	"                        cgroup_inet6_getpeername | cgroup_inet4_getsockname |\n" \
> +	"                        cgroup_inet6_getsockname | cgroup_udp4_sendmsg |\n" \
> +	"                        cgroup_udp6_sendmsg | cgroup_udp4_recvmsg |\n" \
> +	"                        cgroup_udp6_recvmsg | cgroup_sysctl |\n" \
> +	"                        cgroup_getsockopt | cgroup_setsockopt |\n" \
> +	"                        cgroup_inet_sock_release }"
>  
>  static unsigned int query_flags;
>  
>  static enum bpf_attach_type parse_attach_type(const char *str)
>  {
> +	const char *attach_type_str;
>  	enum bpf_attach_type type;
>  
> -	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> -		if (attach_type_name[type] &&
> -		    is_prefix(str, attach_type_name[type]))
> +	for (type = 0; ; type++) {
> +		attach_type_str = libbpf_bpf_attach_type_str(type);
> +		if (!attach_type_str)
> +			break;
> +		if (is_prefix(str, attach_type_str))

With so many shared prefixes here, I'm wondering if it would make more
sense to compare the whole string instead? Otherwise it's hard to guess
which type “bpftool c a <cgroup> cgroup_ <prog>” will use. At the same
time we allow prefixing arguments everywhere else, so maybe not worth
changing it here. Or we could maybe error out if the string length is <=
strlen("cgroup_")? Let's see for a follow-up maybe.

> +			return type;
> +
> +		/* Also check traditionally used attach type strings. */
> +		attach_type_str = bpf_attach_type_input_str(type);
> +		if (!attach_type_str)
> +			continue;
> +		if (is_prefix(str, attach_type_str))
>  			return type;
>  	}
>  

> diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> index c0e7acd..0ca3c1 100755
> --- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> +++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py

> @@ -139,21 +139,20 @@ class FileExtractor(object):
>  
>      def get_types_from_array(self, array_name):
>          """
> -        Search for and parse an array associating names to BPF_* enum members,
> -        for example:
> +        Search for and parse an array white-listing BPF_* enum members, for

The coding style now recommends against the “white-listing”. Maybe
“[...] a list of allowed BPF_* enum members”?

> +        example:
>  
> -            const char * const prog_type_name[] = {
> -                    [BPF_PROG_TYPE_UNSPEC]                  = "unspec",
> -                    [BPF_PROG_TYPE_SOCKET_FILTER]           = "socket_filter",
> -                    [BPF_PROG_TYPE_KPROBE]                  = "kprobe",
> +            const bool prog_type_name[] = {
> +                    [BPF_PROG_TYPE_UNSPEC]                  = true,
> +                    [BPF_PROG_TYPE_SOCKET_FILTER]           = true,
> +                    [BPF_PROG_TYPE_KPROBE]                  = true,
>              };
>  
> -        Return a dictionary with the enum member names as keys and the
> -        associated names as values, for example:
> +        Return a set of the enum members, for example:
>  
> -            {'BPF_PROG_TYPE_UNSPEC': 'unspec',
> -             'BPF_PROG_TYPE_SOCKET_FILTER': 'socket_filter',
> -             'BPF_PROG_TYPE_KPROBE': 'kprobe'}
> +            {'BPF_PROG_TYPE_UNSPEC',
> +             'BPF_PROG_TYPE_SOCKET_FILTER',
> +             'BPF_PROG_TYPE_KPROBE'}
>  
>          @array_name: name of the array to parse
>          """

> @@ -525,34 +521,18 @@ def main():
>      bashcomp_map_types = bashcomp_info.get_map_types()
>  
>      verify(source_map_types, help_map_types,
> -            f'Comparing {MapFileExtractor.filename} (map_type_name) and {MapFileExtractor.filename} (do_help() TYPE):')
> +            f'Comparing {BpfHeaderExtractor.filename} (bpf_map_type) and {MapFileExtractor.filename} (do_help() TYPE):')
>      verify(source_map_types, man_map_types,
> -            f'Comparing {MapFileExtractor.filename} (map_type_name) and {ManMapExtractor.filename} (TYPE):')
> +            f'Comparing {BpfHeaderExtractor.filename} (bpf_map_type) and {ManMapExtractor.filename} (TYPE):')
>      verify(help_map_options, man_map_options,
>              f'Comparing {MapFileExtractor.filename} (do_help() OPTIONS) and {ManMapExtractor.filename} (OPTIONS):')
>      verify(source_map_types, bashcomp_map_types,
> -            f'Comparing {MapFileExtractor.filename} (map_type_name) and {BashcompExtractor.filename} (BPFTOOL_MAP_CREATE_TYPES):')
> +            f'Comparing {BpfHeaderExtractor.filename} (bpf_map_type) and {BashcompExtractor.filename} (BPFTOOL_MAP_CREATE_TYPES):')
>  
>      # Program types (enum)
>  
> -    ref = bpf_info.get_prog_types()
> -
>      prog_info = ProgFileExtractor()

Nit: Let's remove "# Program types (enum)" and move "prog_info = ..."
under "# Attach types"?

> -    prog_types = set(prog_info.get_prog_types().keys())
> -
> -    verify(ref, prog_types,
> -            f'Comparing BPF header (enum bpf_prog_type) and {ProgFileExtractor.filename} (prog_type_name):')
> -
> -    # Attach types (enum)
> -
> -    ref = bpf_info.get_attach_types()
> -    bpf_info.close()
> -
> -    common_info = CommonFileExtractor()
> -    attach_types = common_info.get_attach_types()
> -
> -    verify(ref, attach_types,
> -            f'Comparing BPF header (enum bpf_attach_type) and {CommonFileExtractor.filename} (attach_type_name):')
> +    prog_types = bpf_info.get_prog_types()

It looks like prog_types is unused? I suspect the intention was to
compare with the program types that bpftool supports in prog.c. Looking
at this script, it seems there is no such check currently, which is
likely an ommission on my side. We should add it eventually, but given
that this is beyond the scope of this PR, let's remove "prog_types" for now?

>  
>      # Attach types (names)
>  
