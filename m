Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9815E5530
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 23:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIUV2U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 17:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiIUV1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 17:27:54 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FBBA5C6D
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 14:27:53 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-333a4a5d495so78533047b3.10
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4jRVSaqpLtJkb/UwCnZIyFBnVBd2Q0znVuK7Lz4ZQ7s=;
        b=hZmGXsp5zP6oJFvhJjelwsyPlsgAyiWnPKc4GUUbuunWasrEojNqpp0QXYvC9u1wWM
         yzCA2Xkh3AtTRcc/gW/WslAJqskOvwlLYNYssxlsN6XlHq1N3hck1eXtXdWgK8+wLPA+
         3ACX8RbUNeel9mz89Ot0redqW8QJnxL6M4A8E+zrrMtcBFxNDfNtq5OkMj4qIQrezcXc
         Dnv3wZSDL8IHVt9daYzWyRLjThcmKpKb6cXK1xK31QdhQqR+Bb6xMaFty0svhea6dcew
         t6Xrq7glkmtt0q6flCIXQQ1kz58Wd3MkCswSDXhDDY6YHtR9G4udyJggPhVbRqcoyC3u
         02tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4jRVSaqpLtJkb/UwCnZIyFBnVBd2Q0znVuK7Lz4ZQ7s=;
        b=H8AtIStwPa9ANMf0txUU+PtBKB4OoJZZiTNKI977W1SmB7ibmY17s4D87XthrD3C7r
         2pPfCY530TvOdW+VCYpEHflvHMUPzA0o6R2PnVAPzIdJXxOr0SVTyfoO8fPyv3rTD57k
         pwmHOeNgheCPJXgge24Wb8WRIefKHLtwCOiHbQDoeoNLiA/OVvQOI+pvSSCCQ3QhGowS
         a1oUBOVVwcK+YQcUs1ybcVZcubQiAj0HFsaclxhtFrr3aWxV7U+Cks+cr2t81Tw6ifbH
         3Qs0IuLonz62seYoWAvLOAxNlZLjmGCVfq8LyOt9Ac/yAf6WFwl6qxrgccvpfBIwTsba
         J3oQ==
X-Gm-Message-State: ACrzQf13mKVTiIKz8CyYBoj1kuWU5rrAkKHVYajZTGDFkaRvE/cGvD1C
        5wj+Qb3hO7a1TH5YYg/ESajtMIFgDfeBNwT9XmgDzUex
X-Google-Smtp-Source: AMsMyM4/maAZ1AHCeR0WR+M+RRMtBeOt1oJRRUZNG313dgh9w7r4khqVBnc9GeiA0WDfeJq+MSTzW0GQNQ1Ds+qSRsY=
X-Received: by 2002:a81:9303:0:b0:34d:22dd:3d4e with SMTP id
 k3-20020a819303000000b0034d22dd3d4emr248938ywg.229.1663795671880; Wed, 21 Sep
 2022 14:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220911122328.306188-1-shmulik.ladkani@gmail.com>
 <20220911122328.306188-2-shmulik.ladkani@gmail.com> <0c606d51-685d-9874-7155-c21d2fe06320@huawei.com>
In-Reply-To: <0c606d51-685d-9874-7155-c21d2fe06320@huawei.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 21 Sep 2022 23:27:16 +0200
Message-ID: <CAP01T74sz8fjqLK_Ynx2ebF=rKmkerQn9aLuLZZjb5V5zOD0Ow@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 1/4] bpf: Export 'bpf_dynptr_get_data,
 bpf_dynptr_get_size' helpers
To:     Hou Tao <houtao1@huawei.com>
Cc:     Shmulik Ladkani <shmulik@metanetworks.com>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 21 Sept 2022 at 10:46, Hou Tao <houtao1@huawei.com> wrote:
>
> Hi,
>
> On 9/11/2022 8:23 PM, Shmulik Ladkani wrote:
> > This allows kernel code dealing with dynptrs obtain dynptr's available
> > size and current (w. proper offset) data pointer.
> >
> > Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> SNIP
> > +
> > +static inline void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr)
> > +{
> > +     return ptr->data ? ptr->data + ptr->offset : NULL;
> > +}
> Have one dummy question here. Is ptr->data == NULL is possible ? According to
> the function prototype of bpf_dynptr_from_mem(), data can not be NULL. And IMO
> in order to simplify the usage of bpf_dynptr_kernel, we need to ensure ptr->data
> should be not NULL, else will need to add a NULL checking for every access of
> bpf_dynptr_kernel in kernel.

Yes, ptr->data can always be NULL. And I think at this point if you're
accepting dynptr from BPF programs, the ship has sailed on ensuring it
is always non-NULL (and honestly I don't know if there's a huge
advantage to it vs the amount of verifier work that would be needed to
enable this).

For an example, see how bpf_ringbuf_reserve_dynptr sets it to NULL on
error. Verifier still tracks it as valid initialized dynptr, but later
operations will simply fail or return without doing anything at
runtime.
