Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83A34BBFC6
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 19:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbiBRSoH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 13:44:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiBRSoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 13:44:07 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8DC46150
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 10:43:50 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d5258e8a4bso50968627b3.22
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PHfw6xx6c0taNk2E2UFLBQOVppeHAELs5PlWhfFWfrU=;
        b=i6AhCQiLhSIjzBdYxT978d0W15E0nO/UUSqrtUlfSFJ4bEirNpRm16+HH8ncsatmM5
         4NB/jP0U60zWEkL9374OCb/GZbQjlpERCS9PIe9bEAoIg2AIl89PY9PEvEAoeR9h+EXe
         W+mMbbwjPmKwHw9+asU2vAiPpbzDvTvrtDxTlLD2mcxuMSg87l639ZWGvXnzPbh5n2R+
         ALW1ps3IbFSxV/Yy3G553k2HUpm7a3Irp59M1PbtFReDMPAlaUPgkF2im4bIVMDDC8+I
         B9dKuUXcJzi9uWkJuQ35kFFeZ9EQ6z0tx6sIkbI+X1TYohe/OK8pEHe4j+MxsXf5L31e
         /Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PHfw6xx6c0taNk2E2UFLBQOVppeHAELs5PlWhfFWfrU=;
        b=5X2hSYCEkIcyPQqUHSU1WxEtd8tYyycfTXEtYSuv8UdMwkM57nD8lXDNgosg12EIAM
         FXRJ5Vxe4vXUzIwFiVQJeWselCwBrsMtq8XVHhFBLGpu7DsyVXgPK1alvHiQK70vO/R9
         s5W8je+aw/Qxhc1YN+4ooj9kB7rrpUc2QYHD6Yz8N1GrAFmsaN0MJEJQ2ITs8mgos+oj
         L5Lg3ljh0ZoluoSlwAvT5YFoD2VWk0oEagO7zy6LwUMvAGIdKV6tonHxyG6mK4i8e6o4
         1txhZwuGb9LWP12XNoj0phQZeCh4uD15XvqngI3KS2/hRm4CXT/BrUbecCBwTCFJyz0Z
         VWaw==
X-Gm-Message-State: AOAM533qBwKhmRTPYtO5oVZe8PmzV8LnLoMB++NXZ9EpZpPypd6wOXnV
        uv7C2CI1j919igQO72TKAFkfzDs=
X-Google-Smtp-Source: ABdhPJzmZsbZjil2DNai6DfyrViHdmxTr6/Ly4zpkQgiOGdFYkLNPiagbpB521WHNVMVunL2Akg5vVs=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:fe1b:290d:4724:ef64])
 (user=sdf job=sendgmr) by 2002:a81:6d4c:0:b0:2ca:287c:6c26 with SMTP id
 i73-20020a816d4c000000b002ca287c6c26mr8781345ywc.203.1645209829315; Fri, 18
 Feb 2022 10:43:49 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:43:47 -0800
In-Reply-To: <20220218181801.2971275-1-eric.dumazet@gmail.com>
Message-Id: <Yg/o4x6rD+oLb4Eu@google.com>
Mime-Version: 1.0
References: <20220218181801.2971275-1-eric.dumazet@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Call maybe_wait_bpf_programs() only once
 from generic_map_delete_batch()
From:   sdf@google.com
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>,
        Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/18, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>

> As stated in the comment found in maybe_wait_bpf_programs(),
> the synchronize_rcu() barrier is only needed before returning
> to userspace, not after each deletion in the batch.

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Stanislav Fomichev <sdf@google.com>

Makes sense. Probably a copy-paste from the non-batch case...

Reviewed-by: Stanislav Fomichev <sdf@google.com>

> Cc: Brian Vazquez <brianvv@google.com>
> ---
>   kernel/bpf/syscall.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index  
> a72f63d5a7daee057bcec3fa6119aca32e2945f7..9c7a72b65eee0ec8d54d36e2c0ab9ff4962091af  
> 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1352,7 +1352,6 @@ int generic_map_delete_batch(struct bpf_map *map,
>   		err = map->ops->map_delete_elem(map, key);
>   		rcu_read_unlock();
>   		bpf_enable_instrumentation();
> -		maybe_wait_bpf_programs(map);
>   		if (err)
>   			break;
>   		cond_resched();
> @@ -1361,6 +1360,8 @@ int generic_map_delete_batch(struct bpf_map *map,
>   		err = -EFAULT;

>   	kvfree(key);
> +
> +	maybe_wait_bpf_programs(map);
>   	return err;
>   }

> --
> 2.35.1.473.g83b2b277ed-goog

