Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7208E395315
	for <lists+bpf@lfdr.de>; Sun, 30 May 2021 23:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhE3VrA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 May 2021 17:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229827AbhE3VrA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 30 May 2021 17:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622411121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sEIuj6az0d2ykBNy5PZMlp8C52D/SiimBFUn3fLnAjQ=;
        b=RC70+m1blRqdRUP5V5Av5tnqeG4AvLTUuyXbo3RytPq63HOLlqnK1LqC4xmOJS5qjznckP
        +mj/kjSmTfqFfdZqcLjVIIvC9/qrBGOOq6llSFYQm81NmruVDFgfMAnEfJgjmBnsMrOqxc
        f0BsRYizdzfjP0X+R5HGMxnB+S82ODs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-me5YDP8KNEixpmUUZVBC3g-1; Sun, 30 May 2021 17:45:19 -0400
X-MC-Unique: me5YDP8KNEixpmUUZVBC3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 267BF801B14;
        Sun, 30 May 2021 21:45:18 +0000 (UTC)
Received: from krava (unknown [10.40.192.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 40AEE5D6D7;
        Sun, 30 May 2021 21:45:16 +0000 (UTC)
Date:   Sun, 30 May 2021 23:45:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFT] Testing 1.22
Message-ID: <YLQHax7hZqfFS4Tf@krava>
References: <YK+41f972j25Z1QQ@kernel.org>
 <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
 <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com>
 <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com>
 <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLFIW9fd9ZqbR3B9@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 28, 2021 at 04:45:31PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 27, 2021 at 01:41:13PM -0700, Andrii Nakryiko escreveu:
> > On Thu, May 27, 2021 at 12:57 PM Arnaldo <arnaldo.melo@gmail.com> wrote:
> > > On May 27, 2021 4:14:17 PM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > >If we make 1.22 mandatory there will be no good reason to make 1.23
> > > >mandatory again. So I will have absolutely no inclination to work on
> > > >this, for example. So we are just wasting a chance to clean up the
> > > >Kbuild story w.r.t. pahole. And we are talking about just a few days
> > > >at most, while we do have a reasonable work around on the kernel side.
> 
> > > So there were patches for stop using objcopy, which we thought could
> > > uncover some can of worms, were there patches for the detached BTF
> > > file?
>  
> > No, there weren't, if I remember correctly. What's the concern,
> > though? That detached BTF file isn't even an ELF, so it's
> > btf__get_raw_data() and write it to the file. Done.
> 
> See patch below, lightly tested, now working on making pahole accept raw
> BTF files out of /sys/kernel/btf/
> 
> Please test, and if works as expected, try to bolt this into the kbuild
> process, as intended.
> 
> - Arnaldo
> 
> commit b579a18a1ea0ee84b90b5302f597dda2edf2f61b
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri May 28 16:41:30 2021 -0300
> 
>     pahole: Allow encoding BTF into a detached file
>     
>     Previously the newly encoded BTF info was stored into a ELF section in
>     the file where the DWARF info was obtained, but it is useful to just
>     dump it into a separate file, do it.
>     
>     Requested-by: Andrii Nakryiko <andrii@kernel.org>
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 033c927b537dad1e..bc3ac72968cea826 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -21,6 +21,14 @@
>  #include <stdlib.h> /* for qsort() and bsearch() */
>  #include <inttypes.h>
>  
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +#include <unistd.h>
> +
> +#include <errno.h>
> +
>  /*
>   * This corresponds to the same macro defined in
>   * include/linux/kallsyms.h
> @@ -267,14 +275,62 @@ static struct btf_elf *btfe;
>  static uint32_t array_index_id;
>  static bool has_index_type;
>  
> -int btf_encoder__encode()
> +static int btf_encoder__dump(struct btf *btf, const char *filename)
> +{
> +	uint32_t raw_btf_size;
> +	const void *raw_btf_data;
> +	int fd, err;
> +
> +	/* Empty file, nothing to do, so... done! */
> +	if (btf__get_nr_types(btf) == 0)
> +		return 0;
> +
> +	if (btf__dedup(btf, NULL, NULL)) {
> +		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
> +		return -1;
> +	}
> +
> +	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
> +	if (raw_btf_data == NULL) {
> +                fprintf(stderr, "%s: btf__get_raw_data failed!\n", __func__);
> +		return -1;
> +	}
> +
> +	fd = open(filename, O_WRONLY | O_CREAT);

I think you need to specify file mode as 3rd param:

	$ ./pahole -j krava vmlinux 
	$ ~/linux/tools/bpf/bpftool/bpftool btf dump file ./krava 
	Error: failed to load BTF from ./krava: Permission denied
	$ ll krava 
	--w-r-Sr-T. 1 jolsa jolsa 4525734 May 30 23:38 krava

jirka

