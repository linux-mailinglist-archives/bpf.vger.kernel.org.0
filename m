Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F2F6CAAC2
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjC0QhE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 12:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjC0QhE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 12:37:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932BE129
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 09:37:03 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id j18-20020a170902da9200b001a055243657so6087897plx.19
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679935023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=20oT2OlboIa62PDTsjAChZV3DvgESjfcEiFtIuM/Kzg=;
        b=TXzUBTkkpoG7nUbu/4wDllRHje4Z/evVjGO60hKX/AFnOmJs9LamYzNUb+YnkC0moG
         CzBeic8a/WEMfSyYLxT0RPSzGBoRFy1oAnOznukUVP8NsBoOLoCmiMLwsdtMl0h4cS4s
         oxnJYYBzaiSXpszRsF48tdZz3mBY/ASe67NN9/n1PgxNYrVr5mSErVYSVhWFHjWktMFG
         CoSE5uFxJpbihlkfoaRRvgLtI/rrGWjnucCQ1OF3FGH91ws1zIk4jf6StC6HQIgXzjrv
         l5xGsCtph7jxoYXFd7b8fn4YdpHpgjR1YB9vjeh6+Y+dy4QgGvDNFScI6hJuED6QagO+
         wx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679935023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20oT2OlboIa62PDTsjAChZV3DvgESjfcEiFtIuM/Kzg=;
        b=uMbTaZbbK1/2xcM9EktSUWqgCK9JnleBiN4VkXgMyvhbyoLAbCwxuHczC8VQ+GruHR
         egJEo0NNytfQs5HaPGDiA5NGXo+gnsy8eC8azMEZbWZk7IBlpreP/pgDrZ56QPcTkM+H
         hpRFbrwByuymxETybn3L9uCAxHatWZ3ZrPqIjqghJtHOl4DLKiCElZMeVbKZzHy/cJc8
         VLzzZxIJs5GVuHdfFEzqLd7f4/cUgYYbOCNbK/BaOfJ74Uy5JxmYGf3g6aQzgHsyKRgX
         BugOKRtkFsxFMuIjRDfYZBs21ezkiHZ4u3U8Hbq3G6B3rCTjaIo5VA58h8gitJ0MHwD4
         PmPQ==
X-Gm-Message-State: AAQBX9eIP9sm02Wg+NEo3KNuVy8gud0ELey58AATEyo55ldlxSyVd0Z4
        ZbyPnUHV5BDJr1ZzJbxsCuk3Fis=
X-Google-Smtp-Source: AKy350Y5AgmKx+4AfXw9uIiIX/lUFUvKb8FB6kunmYupmoNnZk0qixZT+OWPLM0f0ieNUoI06Mc29SU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:c101:b0:1a1:e48b:98b8 with SMTP id
 1-20020a170902c10100b001a1e48b98b8mr4741746pli.10.1679935023100; Mon, 27 Mar
 2023 09:37:03 -0700 (PDT)
Date:   Mon, 27 Mar 2023 09:37:01 -0700
In-Reply-To: <20230326095341.816023-1-hengqi.chen@gmail.com>
Mime-Version: 1.0
References: <20230326095341.816023-1-hengqi.chen@gmail.com>
Message-ID: <ZCHGLTMeT7089yBu@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Don't assume page size is 4096
From:   Stanislav Fomichev <sdf@google.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/26, Hengqi Chen wrote:
> The verifier test creates BPF ringbuf maps using hard-coded
> 4096 as max_entries. Some tests will fail if the page size
> of the running kernel is not 4096. Use getpagesize() instead.

> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Can you share which platform that is? The fix seems ok, but
I'm assuming that we have many more places where 4k is hardcoded :-)


> ---
>   tools/testing/selftests/bpf/test_verifier.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/tools/testing/selftests/bpf/test_verifier.c  
> b/tools/testing/selftests/bpf/test_verifier.c
> index 5b90eef09ade..e4657c5bc3f1 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1079,7 +1079,7 @@ static void do_test_fixup(struct bpf_test *test,  
> enum bpf_prog_type prog_type,
>   	}
>   	if (*fixup_map_ringbuf) {
>   		map_fds[20] = create_map(BPF_MAP_TYPE_RINGBUF, 0,
> -					   0, 4096);
> +					 0, getpagesize());
>   		do {
>   			prog[*fixup_map_ringbuf].imm = map_fds[20];
>   			fixup_map_ringbuf++;
> --
> 2.31.1
