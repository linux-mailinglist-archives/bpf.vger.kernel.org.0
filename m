Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460E727237
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 00:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfEVWYk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 18:24:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36650 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfEVWYk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 18:24:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so1739920plr.3
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E8hgoVg7Z24mHuKhx6PCXKnN1YCFRZlKI7hEdBBG7n4=;
        b=quVY0HJMdq36jTE+oPCZRu2+0OMjilZHQzHr4/10w72TxfMi3ATKW0ufXorXHkICqe
         luRKesQxx+PlINxvpYLGqkSklsX4zkRZ1I0gE9iYilbRoQFsx+E8XR7kBaliDeYBKaCA
         R5wxkcTddQst2E6V6H/c8YgbqJkpQ1AN4TiNAKhYZvYyAOkp4yjEK8qwqBTRBc6UCKzF
         xwuwSTprQHJswWcNOrtiYPCW2HOHmdh+H/zGCOdnXkSqN1XjrtjiNByYyB6z0jyZr7wu
         U4/hnNvWSTpxH8TOHXmiQTxXIKDTqGLB8UYyAzqqNYKRfKZ1xrN/TS1A+PmMK0Tg4m+t
         1Bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E8hgoVg7Z24mHuKhx6PCXKnN1YCFRZlKI7hEdBBG7n4=;
        b=W/B8evnENUdlWWQx+6e9Xr0xD0plm22ocpq2JBclJYSHBYdCwASUA62oo8Ex6gHwzo
         pTlX+XwoolQ5tmLRe/jgjt2yAU31c4FDX57u/0tnt3abZt415rF8eofdqqeld9IAz7mr
         OIiO+c08WSC86hXA5N3rHG2OY6rQF9MXe2AHZ+Yhy4I3KhPqDgJcxyhRPFi+DYMEkBMf
         4J8k9XKL++p20ZxW2dIxjENE0Nl2+TtAHS2BQiH1Sp0yLO0ifPYscfftfR4UFWgNVJRL
         A0YvgcLJyVfAg+LUQ+z8LRb7wxez5QiwN9aiPSVnDmdy708sjVeB8vUh8P0CS/xHPnAK
         n2qw==
X-Gm-Message-State: APjAAAWAfJid8p9DVRAiBn+fRkiM+LOLIbmZxHsHV2vlTpu4Lx4WSnnv
        znCqzHtkk2futQy4I1US+RZfyw==
X-Google-Smtp-Source: APXvYqxkgZbzSmd6t8agbXVg5UXWApsR52ikdByEGUJsWpxNdG2MULr0UKlxHh0lnCaN6AHeDmw3yQ==
X-Received: by 2002:a17:902:e104:: with SMTP id cc4mr92594084plb.254.1558563879723;
        Wed, 22 May 2019 15:24:39 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id l7sm28242494pfl.9.2019.05.22.15.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 15:24:38 -0700 (PDT)
Date:   Wed, 22 May 2019 15:24:38 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: add auto-detach test
Message-ID: <20190522222438.GB3032@mini-arch>
References: <20190522212932.2646247-1-guro@fb.com>
 <20190522212932.2646247-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522212932.2646247-5-guro@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/22, Roman Gushchin wrote:
> Add a kselftest to cover bpf auto-detachment functionality.
> The test creates a cgroup, associates some resources with it,
> attaches a couple of bpf programs and deletes the cgroup.
> 
> Then it checks that bpf programs are going away in 5 seconds.
> 
> Expected output:
>   $ ./test_cgroup_attach
>   #override:PASS
>   #multi:PASS
>   #autodetach:PASS
>   test_cgroup_attach:PASS
> 
> On a kernel without auto-detaching:
>   $ ./test_cgroup_attach
>   #override:PASS
>   #multi:PASS
>   #autodetach:FAIL
>   test_cgroup_attach:FAIL
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  .../selftests/bpf/test_cgroup_attach.c        | 108 +++++++++++++++++-
>  1 file changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_cgroup_attach.c b/tools/testing/selftests/bpf/test_cgroup_attach.c
> index 93d4fe295e7d..36441fd0f392 100644
> --- a/tools/testing/selftests/bpf/test_cgroup_attach.c
> +++ b/tools/testing/selftests/bpf/test_cgroup_attach.c
> @@ -456,9 +456,115 @@ static int test_multiprog(void)
>  	return rc;
>  }
>  
> +static int test_autodetach(void)
> +{
> +	__u32 prog_cnt = 4, attach_flags;
> +	int allow_prog[2] = {0};
> +	__u32 prog_ids[2] = {0};
> +	int cg = 0, i, rc = -1;
> +	void *ptr = NULL;
> +	int attempts;
> +
> +
> +	for (i = 0; i < ARRAY_SIZE(allow_prog); i++) {
> +		allow_prog[i] = prog_load_cnt(1, 1 << i);
> +		if (!allow_prog[i])
> +			goto err;
> +	}
> +
> +	if (setup_cgroup_environment())
> +		goto err;
> +
> +	/* create a cgroup, attach two programs and remember their ids */
> +	cg = create_and_get_cgroup("/cg_autodetach");
> +	if (cg < 0)
> +		goto err;
> +
> +	if (join_cgroup("/cg_autodetach"))
> +		goto err;
> +
> +	for (i = 0; i < ARRAY_SIZE(allow_prog); i++) {
> +		if (bpf_prog_attach(allow_prog[i], cg, BPF_CGROUP_INET_EGRESS,
> +				    BPF_F_ALLOW_MULTI)) {
> +			log_err("Attaching prog[%d] to cg:egress", i);
> +			goto err;
> +		}
> +	}
> +
> +	/* make sure that programs are attached and run some traffic */
> +	assert(bpf_prog_query(cg, BPF_CGROUP_INET_EGRESS, 0, &attach_flags,
> +			      prog_ids, &prog_cnt) == 0);
> +	assert(system(PING_CMD) == 0);
> +
> +	/* allocate some memory (4Mb) to pin the original cgroup */
> +	ptr = malloc(4 * (1 << 20));
> +	if (!ptr)
> +		goto err;
> +
> +	/* close programs and cgroup fd */
> +	for (i = 0; i < ARRAY_SIZE(allow_prog); i++) {
> +		close(allow_prog[i]);
> +		allow_prog[i] = 0;
> +	}
> +
> +	close(cg);
> +	cg = 0;
> +
> +	/* leave the cgroup and remove it. don't detach programs */
> +	cleanup_cgroup_environment();
> +

[..]
> +	/* programs must stay pinned by the allocated memory */
> +	for (i = 0; i < ARRAY_SIZE(prog_ids); i++) {
> +		int fd = bpf_prog_get_fd_by_id(prog_ids[i]);
> +
> +		if (fd < 0)
> +			goto err;
> +		close(fd);
> +	}
This looks a bit flaky. It's essentially the same check you later
do in a for loop. I guess there is a chance that async auto-detach
might happen right after cleanup_cgroup_environment and before this for loop?

> +
> +	/* wait for the asynchronous auto-detachment.
> +	 * wait for no more than 5 sec and give up.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(prog_ids); i++) {
> +		for (attempts = 5; attempts >= 0; attempts--) {
> +			int fd = bpf_prog_get_fd_by_id(prog_ids[i]);
> +
> +			if (fd < 0)
> +				break;
> +
> +			/* don't leave the fd open */
> +			close(fd);
> +
> +			if (!attempts)
> +				goto err;
> +
> +			sleep(1);
> +		}
> +	}
> +
> +	rc = 0;
> +err:
> +	for (i = 0; i < ARRAY_SIZE(allow_prog); i++)
> +		if (allow_prog[i] > 0)
> +			close(allow_prog[i]);
> +	if (cg)
> +		close(cg);
> +	free(ptr);
> +	cleanup_cgroup_environment();
> +	if (!rc)
> +		printf("#autodetach:PASS\n");
> +	else
> +		printf("#autodetach:FAIL\n");
> +	return rc;
> +}
> +
>  int main(int argc, char **argv)
>  {
> -	int (*tests[])(void) = {test_foo_bar, test_multiprog};
> +	int (*tests[])(void) = {
> +		test_foo_bar,
> +		test_multiprog,
> +		test_autodetach,
> +	};
>  	int errors = 0;
>  	int i;
>  
> -- 
> 2.20.1
> 
