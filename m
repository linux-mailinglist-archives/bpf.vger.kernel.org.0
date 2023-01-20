Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244B6674CB8
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjATFsl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjATFse (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:48:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE912B0B3;
        Thu, 19 Jan 2023 21:48:27 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso3919105pjf.1;
        Thu, 19 Jan 2023 21:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLckVKMyCStZwhys+tGMr+ONU8XRJJii/uYGfvRPuqk=;
        b=qwFL3BTnwx+lC5UPdZCPFPdwr3EOoGiOYMTDKF2UVBqEHJsBMDmQYs2fUPnLvvZARs
         aNh6pB+BB3kFJnjlbXckO5EsUmLngH5Nd7kNKlKTve7f6OHgvwjKTCUEmMdTxIDd5x0X
         gYZI/EtVl0llNtG8Q6IsACxm8E0CE314fblm42a6+ZidIWwHZQIrJDCxkW38rhDip+FQ
         ppOSuLJZUBH5LTmoI0aMcWS6Tk1NL4LBHU45Fu/I/bSNjxXHHm+N7QscCI4LyIG9pl1T
         12Jv2ICqfufwyPk7UvTRoQnCRhGgntL6ZzaBT3w9oWptuVSP1o+NcA/d+F2HqUBteUPl
         /nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLckVKMyCStZwhys+tGMr+ONU8XRJJii/uYGfvRPuqk=;
        b=nUCfjYSqbwFxAmckEVXsKxciqcBHI/95gxNmBwRn0DtTO+zv/8iyb1Rly49dCdMn2f
         +HkUAM+jegwd/aXO+flQcuxofq/2pvW8V+J7WvMB9mxt3dXnfO842Qtb+Nu/Ilm4VwDG
         MK+qZpy6comJK1izRFclIVHhSU4+xiLcgDSAPw2EFHCvphUZgum3xJXW9Ui+jy5nUkPI
         9jCY7ZwkeNzSzq0If1xcy6bzQt797jlZZRvtgSCi1x7s7Bp0qR1JaJeOlLG5uTwLNdKI
         H9YVq+d6bhhV9N5MUPhaW9+5qLcBKf6PzSRs+Wh4V+xOeQiiT59akbNbE20Mok1/+vzr
         veVA==
X-Gm-Message-State: AFqh2kqhOncw4h9i6OogTQZTft5DzEYdyTY2OcIK4BiuNlyANJ/RfPFP
        KZobkZUwefH4EGfkHdYIav6PVaB7LtY=
X-Google-Smtp-Source: AMrXdXvzVo4gOjNuSZgwrLNukL6C/vPF9swYkNLNwGYXbrko/QoL3S7YNmp5B5ip8mMQrF/idKa1fA==
X-Received: by 2002:a05:6a21:151b:b0:b8:828c:9229 with SMTP id nq27-20020a056a21151b00b000b8828c9229mr13837139pzb.36.1674193707224;
        Thu, 19 Jan 2023 21:48:27 -0800 (PST)
Received: from MacBook-Pro-6.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:186c])
        by smtp.gmail.com with ESMTPSA id n6-20020a634d46000000b004351358f056sm21562927pgl.85.2023.01.19.21.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:48:26 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:48:23 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 4/8] bpf: Enable cpumasks to be queried and used
 as kptrs
Message-ID: <20230120054823.bldnkx5tl3jxejm3@MacBook-Pro-6.local.dhcp.thefacebook.com>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-5-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119235833.2948341-5-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 05:58:29PM -0600, David Vernet wrote:
> silently check for and ignore these cases at runtime. When we have e.g.
> per-argument kfunc flags, it might be helpful to add another KF_CPU-type
> flag that specifies that the verifier should validate that it's a valid
> CPU.

...

> +void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
> +{
> +	if (!cpu_valid(cpu))
> +		return;
> +
> +	cpumask_set_cpu(cpu, (struct cpumask *)cpumask);
> +}

...

> +void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
> +{
> +	if (!cpu_valid(cpu))
> +		return;

I don't think we'll be able to get rid of this with KF_CPU or special suffix.
The argument might be a variable and not a constant at the verification time.
We would have to allow passing unknown vars otherwise the UX will be too restrictive,
so this run-time check would have to stay.
