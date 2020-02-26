Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D689216FFB8
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2020 14:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgBZNNC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Feb 2020 08:13:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42663 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgBZNNC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Feb 2020 08:13:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id 83so1929353lfh.9
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2020 05:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=VdhHrXjl+PKXd1l0Jfah9G+IGjp6vwTwBHwOu50n8sw=;
        b=HfYfVZsOjXxTr2vxVBObYSDTHYGkeN6N7IhqxGoU5Ok7JykNPVrPCE788nx+fjPl23
         vZLT3RlQkwS4AhYagHZk7192HG7ODj0FxagKKangVWlLyW6ObJtCFRKRTRl/4UZOwGht
         rqBqOjEVC9cbo79bs9HABZunZYRAnJP2M3iiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=VdhHrXjl+PKXd1l0Jfah9G+IGjp6vwTwBHwOu50n8sw=;
        b=bJh/m1ds1uYZ6N37R7RTUmglk6QXd4YNiWekP5m952rhVKrxfrQuLjwGYlEF2rj8V0
         hHHvzOr7y0bogi/I769CYv2wRCPbA9OnffxPa2E+vSjxWrpvN37cfcPE1LNGVhA71zrG
         JstzCWVGc8ELu5jQS+vAHHzFrofX2q3hqQ0UuPkEuQ8xMie7Mtd40t0dUyfKVYNWrIqi
         ibh8TQHxXr/Dlmes6Ue6gNC/M0GPQN59Z1iMkz6MXwpctpdcrEaM8t0WvDMBB0plJPI0
         cKKqjKUpvBi+GRmHP7I2v8fISC2dpjv45h/GuDsxuRo4Z0HSf7PrDVqKEY4FXrciNXqT
         Afpw==
X-Gm-Message-State: APjAAAVcJM56o4jFfDUJpwS9UY2OSRF9prblhDEL1z/xSf7X4q7BzA4P
        aFZQ+DODLSpUygY/gDnrlM67Rw==
X-Google-Smtp-Source: APXvYqyk12gk5w3T1MyCmjVV0V/KRRuYtatHfQg26Uspvyk9w+9w+u4vyBYFnMS6zjjSGWSUPmAmcQ==
X-Received: by 2002:ac2:5a05:: with SMTP id q5mr2451450lfn.143.1582722778414;
        Wed, 26 Feb 2020 05:12:58 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id n3sm1185849ljc.100.2020.02.26.05.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 05:12:57 -0800 (PST)
References: <20200225135636.5768-1-lmb@cloudflare.com> <20200225135636.5768-8-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 7/7] selftests: bpf: enable UDP sockmap reuseport tests
In-reply-to: <20200225135636.5768-8-lmb@cloudflare.com>
Date:   Wed, 26 Feb 2020 14:12:56 +0100
Message-ID: <87d0a1cx0n.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 25, 2020 at 02:56 PM CET, Lorenz Bauer wrote:
> Remove the guard that disables UDP tests now that sockmap has support for them.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> index 68d452bb9fd9..4c09766344a4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> +++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> @@ -816,13 +816,6 @@ static void test_config(int sotype, sa_family_t family, bool inany)
>  		if (!test__start_subtest(s))
>  			continue;
>
> -		if (sotype == SOCK_DGRAM &&
> -		    inner_map_type != BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
> -			/* SOCKMAP/SOCKHASH don't support UDP yet */
> -			test__skip();
> -			continue;
> -		}
> -
>  		setup_per_test(sotype, family, inany, t->no_inner_map);
>  		t->fn(sotype, family);
>  		cleanup_per_test(t->no_inner_map);

This one will need a respin due to 779e422d1198 ("selftests/bpf: Run
reuseport tests only with supported socket types") that landed recently
in bpf-next.
