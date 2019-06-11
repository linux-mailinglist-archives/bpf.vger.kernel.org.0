Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F03C207
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2019 06:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfFKESo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jun 2019 00:18:44 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40927 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfFKESn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jun 2019 00:18:43 -0400
Received: by mail-yw1-f66.google.com with SMTP id b143so4705277ywb.7
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 21:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1x6+Y2pwnNkBGDLDQA27k+oCJGbUQsBRY2G4PLVMDls=;
        b=DR6BhtQGonLnYvn7MNiu4oDO4frfF5lm0jDwdze6mJweZW2VPxmDkOqbWk7razp5gg
         bdVvcrS0r8nubVk2zMqyBYVvwrxirqlTI9dqwRavbMDIBjq7eO3ad4f41WGSlivGQh42
         eyB3OBY3gxo5JJ5cF0WT6BrH9Qqdv8c0KegfBux6R2jqEYvD1Nsgf5k7D45keJbUTQDp
         FcVX1cWfyDGO0Yn+hNiDg9ZTtnZ7QH81HkIelZYJ5TD2GJOY46aX6QvU+X4b20scQAb0
         LO4vYIs5ZVFeuB/4RdE8nwmK5PBo27o0/Umzezct2J7CzY2kxx+JCFZHeCnx3eSHiSA8
         3KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1x6+Y2pwnNkBGDLDQA27k+oCJGbUQsBRY2G4PLVMDls=;
        b=mcwb1KU9b48tqTVy5MGbZGmr3tnlB9IfqcbP/8Aws9jTK5ecJITlrBoIlbywPIB1HV
         Pt/PMFVkQYo+QUs9XAnvFW29ho44BlzPAORR1OdJ+MYDu26GjtSx1z13oAjANNgLbv+D
         yVu/SuXdcMdbek+2AW5AKKE1K9IaZEE6ukQdHnPfkJAAbofBciq50w/FXoy+0biIdGYA
         nOgvjg2py+0evTnoAs9ur7ZTPzPndi/6p73zkuaSawWMjdAovA0emDKL9G4YkYG+flD6
         FC9X1QqZqIUKKQAxOFkHlRlj1Uv4z9qwU93b2pcCXOktCCFtkSKgHh/P6LUfiLvDMAkO
         kYLg==
X-Gm-Message-State: APjAAAVzgKxvQrxS9kJAr8id/Hbq2VRHfVxYXLANIQF6ANS/O4y6EnyK
        bxXwLmsIBXaFBfaXsmrzul5aiw==
X-Google-Smtp-Source: APXvYqxOsQ69YPJhEntFbAK3zQJ0QzYFDoPf9fvyE2C7QqmQ7Ih7XSXq6zrapPl2POLHDJeDNof+HQ==
X-Received: by 2002:a81:3715:: with SMTP id e21mr11019981ywa.33.1560226721916;
        Mon, 10 Jun 2019 21:18:41 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id q63sm3769235ywq.17.2019.06.10.21.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 21:18:40 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:18:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf augmented_raw_syscalls: Support arm64 raw
 syscalls
Message-ID: <20190611041831.GA3959@leoy-ThinkPad-X240s>
References: <20190606094845.4800-1-leo.yan@linaro.org>
 <20190606094845.4800-4-leo.yan@linaro.org>
 <20190606133838.GC30166@kernel.org>
 <20190606141231.GC5970@leoy-ThinkPad-X240s>
 <20190606144412.GC21245@kernel.org>
 <20190607095831.GG5970@leoy-ThinkPad-X240s>
 <20190609131849.GB6357@leoy-ThinkPad-X240s>
 <20190610184754.GU21245@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610184754.GU21245@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 10, 2019 at 03:47:54PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > > I tested with the lastest perf/core branch which contains the patch:
> > > 'perf augmented_raw_syscalls: Tell which args are filenames and how
> > > many bytes to copy' and got the error as below:
> > > 
> > > # perf trace -e string -e /mnt/linux-kernel/linux-cs-dev/tools/perf/examples/bpf/augmented_raw_syscalls.c
> > > Error:  Invalid syscall access, chmod, chown, creat, futimesat, lchown, link, lstat, mkdir, mknod, newfstatat, open, readlink, rename,
> > > rmdir, stat, statfs, symlink, truncate, unlink
> 
> Humm, I think that we can just make the code that parses the
> tools/perf/trace/strace/groups/string file to ignore syscalls it can't
> find in the syscall_tbl, i.e. trace those if they exist in the arch.

Agree.

> > > Hint:   try 'perf list syscalls:sys_enter_*'
> > > Hint:   and: 'man syscalls'
> > > 
> > > So seems mksyscalltbl has not included completely for syscalls, I
> > > use below command to generate syscalltbl_arm64[] array and it don't
> > > include related entries for access, chmod, chown, etc ...
> 
> So, we need to investigate why is that these are missing, good thing we
> have this 'strings' group :-)
> 
> > > You could refer the generated syscalltbl_arm64 in:
> > > http://paste.ubuntu.com/p/8Bj7Jkm2mP/
> > 
> > After digging into this issue on Arm64, below is summary info:
> > 
> > - arm64 uses the header include/uapi/linux/unistd.h to define system
> >   call numbers, in this header some system calls are not defined (I
> >   think the reason is these system calls are obsolete at the end) so the
> >   corresponding strings are missed in the array syscalltbl_native,
> >   for arm64 the array is defined in the file:
> >   tools/perf/arch/arm64/include/generated/asm/syscalls.c.
> 
> Yeah, I looked at the 'access' case and indeed it is not present in
> include/uapi/asm-generic/unistd.h, which is the place
> include/uapi/linux/unistd.h ends up.
> 
> Ok please take a look at the patch at the end of this message, should be ok?
> 
> I tested it by changing the strace/gorups/string file to have a few
> unknown syscalls, running it with -v we see:
> 
> [root@quaco perf]# perf trace -v -e string ls
> Skipping unknown syscalls: access99, acct99, add_key99
> <SNIP other verbose messages>
> normal operation not considering those unknown syscalls.

I did testing with the patch, but it failed after I added eBPF event
with below command, I even saw segmentation fault; please see below
inline comments.

  perf --debug verbose=10 trace -e string -e \
    /mnt/linux-kernel/linux-cs-dev/tools/perf/examples/bpf/augmented_raw_syscalls.c

[...]

> commit e0b34a78c4ed0a6422f5b2dafa0c8936e537ee41
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Mon Jun 10 15:37:45 2019 -0300
> 
>     perf trace: Skip unknown syscalls when expanding strace like syscall groups
>     
>     We have $INSTALL_DIR/share/perf-core/strace/groups/string files with
>     syscalls that should be selected when 'string' is used, meaning, in this
>     case, syscalls that receive as one of its arguments a string, like a
>     pathname.
>     
>     But those were first selected and tested on x86_64, and end up failing
>     in architectures where some of those syscalls are not available, like
>     the 'access' syscall on arm64, which makes using 'perf trace -e string'
>     in such archs to fail.
>     
>     Since this the routine doing the validation is used only when reading
>     such files, do not fail when some syscall is not found in the
>     syscalltbl, instead just use pr_debug() to register that in case people
>     are suspicious of problems.
>     
>     Now using 'perf trace -e string' should work on arm64, selecting only
>     the syscalls that have a string and are available on that architecture.
>     
>     Reported-by: Leo Yan <leo.yan@linaro.org>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Alexei Starovoitov <ast@kernel.org>
>     Cc: Daniel Borkmann <daniel@iogearbox.net>
>     Cc: Jiri Olsa <jolsa@redhat.com>
>     Cc: Martin KaFai Lau <kafai@fb.com>
>     Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>     Cc: Mike Leach <mike.leach@linaro.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Song Liu <songliubraving@fb.com>
>     Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>     Cc: Yonghong Song <yhs@fb.com>
>     Link: https://lkml.kernel.org/n/tip-oa4c2x8p3587jme0g89fyg18@git.kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 1a2a605cf068..eb70a4b71755 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1529,6 +1529,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
>  static int trace__validate_ev_qualifier(struct trace *trace)
>  {
>  	int err = 0, i;
> +	bool printed_invalid_prefix = false;
>  	size_t nr_allocated;
>  	struct str_node *pos;
>  
> @@ -1555,14 +1556,15 @@ static int trace__validate_ev_qualifier(struct trace *trace)
>  			if (id >= 0)
>  				goto matches;
>  
> -			if (err == 0) {
> -				fputs("Error:\tInvalid syscall ", trace->output);
> -				err = -EINVAL;
> +			if (!printed_invalid_prefix) {
> +				pr_debug("Skipping unknown syscalls: ");
> +				printed_invalid_prefix = true;
>  			} else {
> -				fputs(", ", trace->output);
> +				pr_debug(", ");
>  			}
>  
> -			fputs(sc, trace->output);
> +			pr_debug("%s", sc);
> +			continue;

Here adds 'continue' so that we want to let ev_qualifier_ids.entries
to only store valid system call ids.  But this is not sufficient,
because we have initialized ev_qualifier_ids.nr at the beginning of
the function:

  trace->ev_qualifier_ids.nr = strlist__nr_entries(trace->ev_qualifier);

This sentence will set ids number to the string table's length; but
actually some strings are not really supported; this leads to some
items in trace->ev_qualifier_ids.entries[] will be not initialized
properly.

If we want to get neat entries and entry number, I suggest at the
beginning of the function we use variable 'nr_allocated' to store
string table length and use it to allocate entries:

  nr_allocated = strlist__nr_entries(trace->ev_qualifier);
  trace->ev_qualifier_ids.entries = malloc(nr_allocated *
                                           sizeof(trace->ev_qualifier_ids.entries[0]));

If we find any matched string, then increment the nr field under
'matches' tag:

matches:
                trace->ev_qualifier_ids.nr++;
                trace->ev_qualifier_ids.entries[i++] = id;

This can ensure the entries[0..nr-1] has valid id and we can use
ev_qualifier_ids.nr to maintain the valid system call numbers.

>  		}
>  matches:
>  		trace->ev_qualifier_ids.entries[i++] = id;
> @@ -1591,15 +1593,14 @@ static int trace__validate_ev_qualifier(struct trace *trace)
>  		}
>  	}
>  
> -	if (err < 0) {
> -		fputs("\nHint:\ttry 'perf list syscalls:sys_enter_*'"
> -		      "\nHint:\tand: 'man syscalls'\n", trace->output);
> -out_free:
> -		zfree(&trace->ev_qualifier_ids.entries);
> -		trace->ev_qualifier_ids.nr = 0;
> -	}
>  out:
> +	if (printed_invalid_prefix)
> +		pr_debug("\n");
>  	return err;
> +out_free:
> +	zfree(&trace->ev_qualifier_ids.entries);
> +	trace->ev_qualifier_ids.nr = 0;
> +	goto out;

Nitpick: directly return err and 'goto out' is not necessary.

Thanks,
Leo Yan

>  }
>  
>  /*
