Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657A853D172
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 20:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiFCSbd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 14:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345535AbiFCSbU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 14:31:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F8B193FF
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 11:17:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so7710478pjq.2
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Az2acnj16/aXPRCs4OX6YtuTWRNeGltXq9+PbmTT2go=;
        b=P+Blsdx7NzfX+tc3SEE3y7hR4zxwbKm4W2XIzjhNeSBoA+J3idLz4PKuU0Rgg4bqeT
         8lBP2muYp3hJexMlCEEKRnfjA8kkU7Ktpm+ktqsZzLj/Bps9oNU5lakmUmkSzZZvJbIw
         0qVv48vpCqMPKK6//GckvorWP4FKNyXfKRdKBPD2dx7i7608+Pyv7jcbzu4PhcIU7dL9
         jJ9Mhm1GemcsDHTmQh64GVr7Yiv0UXLF3ltn2JxNuZClpwltYgmNH6Wk0P7s3/watLWM
         9ucceQ8xk1cXq4I+OjOirraMAlWREjNJ1kYf8gOJHA86ZxrD0DrXqxCLe5WOy7pXbakk
         CQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Az2acnj16/aXPRCs4OX6YtuTWRNeGltXq9+PbmTT2go=;
        b=n1+oGI60qkmYIbdEYX/QTDMYxeKq5Dv5olGJdpf2l8X7Zy6e4wfAr+xifydkng9C/3
         /rhyUrmp0S+qCWloNeSlhhfhq6MRKkfpk63knkzZWsp+QfHVevyFLh++OjdqqWPYSiRZ
         H6kycAs3b+BSbgCpvE55qLR2U5efjFNGW2Kfn9NDtro0c6vtgC4hKbdaZvdHebg201Mq
         sDYB+Nufm1Ub6ABwbdOh8NR89XUk2IT6uRvAVAGH6S1/2zdq9Agz6XeP1Pqg9Q274xjb
         wlYTZZLa8c4nBRR/+OXe/id28Uz8Y3h+97jVhzHTnt6brK5/SZUM1L8/+N11T8TU1jb/
         nXrw==
X-Gm-Message-State: AOAM5329wdbqlYlYPzFV7cR9KdjOqTasZZnSEVESwUOtv6dYzBVEsV2T
        yCnhinp+5ltuAYm/QSwA3Uje3g==
X-Google-Smtp-Source: ABdhPJzckn8Awkez5EOaYciBPRY6e4DtCmXwaSw9DADx5xuCE92so+iP50Z8yVuSHpMTrhIC0nGoTA==
X-Received: by 2002:a17:90b:1646:b0:1e3:15ef:2871 with SMTP id il6-20020a17090b164600b001e315ef2871mr27004228pjb.105.1654280244917;
        Fri, 03 Jun 2022 11:17:24 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id bx9-20020a17090af48900b001e270cc443dsm7965713pjb.46.2022.06.03.11.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 11:17:24 -0700 (PDT)
Message-ID: <0c37c2b9-a89a-54d7-9fd3-f035f6816aa8@linaro.org>
Date:   Fri, 3 Jun 2022 11:17:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] cgroup: serialize css kill and release paths
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Koutny <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, cgroups@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
References: <20220603173455.441537-1-tadeusz.struk@linaro.org>
 <20220603181321.443716-1-tadeusz.struk@linaro.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <20220603181321.443716-1-tadeusz.struk@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/3/22 11:13, Tadeusz Struk wrote:
> Syzbot found a corrupted list bug scenario that can be triggered from
> cgroup_subtree_control_write(cgrp). The reproduces writes to
> cgroup.subtree_control file, which invokes:
> cgroup_apply_control_enable()->css_create()->css_populate_dir(), which
> then fails with a fault injected -ENOMEM.
> In such scenario the css_killed_work_fn will be en-queued via
> cgroup_apply_control_disable(cgrp)->kill_css(css), and bail out to
> cgroup_kn_unlock(). Then cgroup_kn_unlock() will call:
> cgroup_put(cgrp)->css_put(&cgrp->self), which will try to enqueue
> css_release_work_fn for the same css instance, causing a list_add
> corruption bug, as can be seen in the syzkaller report [1].
> 
> Fix this by synchronizing the css ref_kill and css_release jobs.
> css_release() function will check if the css_killed_work_fn() has been
> scheduled for the css and only en-queue the css_release_work_fn()
> if css_killed_work_fn wasn't already en-queued. Otherwise css_release() will
> set the CSS_REL_LATER flag for that css. This will cause the
> css_release_work_fn() work to be executed after css_killed_work_fn() is finished.
> 
> Two scc flags have been introduced to implement this serialization mechanizm:
> 
>   * CSS_KILL_ENQED, which will be set when css_killed_work_fn() is en-queued, and
>   * CSS_REL_LATER, which, if set, will cause the css_release_work_fn() to be
>     scheduled after the css_killed_work_fn is finished.
> 
> There is also a new lock, which will protect the integrity of the css flags.
> 
> [1] https://syzkaller.appspot.com/bug?id=e26e54d6eac9d9fb50b221ec3e4627b327465dbd

This also fixes a similar, cgroup related list corrupt issue:
https://syzkaller.appspot.com/bug?id=3c7ff113ccb695e839b859da3fc481c36eb1cfd5

-- 
Thanks,
Tadeusz
