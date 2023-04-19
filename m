Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB96E7D73
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjDSOvL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjDSOvJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 10:51:09 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DED3C0D;
        Wed, 19 Apr 2023 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=XxVD0hipqgth9ZJ1nyMDcD+GdG+KZvFQJbCVZuqDCbk=; b=RLUa4rew4gW8VMttcSSzHFOXI2
        6BJLaD7o1tNNQ2LqmU0sRK1NJ2et0GGUVAXM+O2q7U83WPMphEUIZy0V94y6O9Cd48dO+5YLsvNAU
        RhB0Jv8gdZRT9t1DMpeNYasiieJ7o2PwI4w3bvR8GuaoirxMOwU5hOeRUI9lJN4mHT8zAgUvztaNz
        BPTXvMej8ZarsfTkXlHJGkapQk+gLTnYUwzWUs1RuorT1XkC/c42UUgyucz2E8eZ5oWhAbHxleuFB
        fPnA1VZPfORv9+4tnP7Jk1oLSU0GRH9GAo9vjWnza8LkNMvxY0ooxxFyPKW0xnP7ZQ4LauO9MZcS+
        UuPbG4hA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pp98v-0005CQ-SP; Wed, 19 Apr 2023 16:50:45 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pp98v-000HS5-Gk; Wed, 19 Apr 2023 16:50:45 +0200
Subject: Re: [PATCH] bpftool: fix broken compile on s390 for linux-next
 repository
To:     Thomas Richter <tmricht@linux.ibm.com>, broonie@kernel.org,
        hca@linux.ibm.com, sfr@canb.auug.org.au, liam.howlett@oracle.com,
        acme@redhat.com, ast@kernel.org, bpf@vger.kernel.org,
        linux-next@vger.kernel.org, quentin@isovalent.com
References: <20230418085516.1104514-1-tmricht@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <233a0b88-6857-0a1d-3609-6a74fa50c28c@iogearbox.net>
Date:   Wed, 19 Apr 2023 16:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230418085516.1104514-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26880/Wed Apr 19 09:22:57 2023)
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/18/23 10:55 AM, Thomas Richter wrote:
> Commit 9fd496848b1c ("bpftool: Support inline annotations when dumping the CFG of a program")
> breaks the build of the perf tool on s390 in the linux-next repository.
> Here is the make output:
> 
> make -C tools/perf
> ....
> btf_dumper.c: In function 'dotlabel_puts':
> DEBUG: btf_dumper.c:838:25: error: '__fallthrough' undeclared \
> 		(first use in this function); did you mean 'fallthrough'?
> DEBUG:   838 |                         __fallthrough;
> DEBUG:       |                         ^~~~~~~~~~~~~
> DEBUG:       |                         fallthrough
> DEBUG: btf_dumper.c:838:25: note: each undeclared identifier is reported \
> 		only once for each function it appears in
> DEBUG: btf_dumper.c:837:25: warning: this statement may fall through \
>                  [-Wimplicit-fallthrough=]
> DEBUG:   837 |                         putchar('\\');
> DEBUG:       |                         ^~~~~~~~~~~~~
> DEBUG: btf_dumper.c:839:17: note: here
> DEBUG:   839 |                 default:
> DEBUG:       |                 ^~~~~~~
> DEBUG: make[3]: *** [Makefile:247: /builddir/build/BUILD/kernel-6.2.fc37/\
> 		        linux-6.2/tools/perf/util/bpf_skel/ \
> 		        .tmp/bootstrap/btf_dumper.o] Error 1
> 
> The compile fails because symbol __fallthrough unknown, but symbol
> fallthrough is known and works fine.
> 
> Fix this and replace __fallthrough by fallthrough.
> 
> With this change, the compile works.
> 
> Output after:
> 
>   # make -C tools/perf
>   ....
>   CC      util/bpf-filter.o
>   CC      util/bpf-filter-flex.o
>   LD      util/perf-in.o
>   LD      perf-in.o
>   LINK    perf
>   make: Leaving directory '/root/mirror-linux-next/tools/perf'
>   #
> 
> Fixes: 9fd496848b1c ("bpftool: Support inline annotations when dumping the CFG of a program")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>   tools/bpf/bpftool/btf_dumper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index 6c5e0e82da22..1b7f69714604 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -835,7 +835,7 @@ static void dotlabel_puts(const char *s)
>   		case '|':
>   		case ' ':
>   			putchar('\\');
> -			__fallthrough;
> +			fallthrough;

The problem is however for current bpf-next, where this change breaks CI:

https://github.com/kernel-patches/bpf/actions/runs/4737651765/jobs/8410684531

   [...]
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/bpftool/feature.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/bpftool/disasm.o
   btf_dumper.c:838:4: error: use of undeclared identifier 'fallthrough'
                           fallthrough;
                           ^
   1 error generated.
   [...]

I would suggest as a clean path that'll work for both to just change from
fallthrough; into /* fallthrough */ as done in objtool, then we can also
work around BPF CI issue and merge this change in time.

>   		default:
>   			putchar(*s);
>   		}
> 

