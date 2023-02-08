Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12468F38F
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 17:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjBHQl2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 11:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjBHQkw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 11:40:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508D74DE1B
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 08:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675874396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rkYkOL9mSyKYEtuavWiOPhy6b7dpdKwTrCd9LzJhy+8=;
        b=G6+eS4aHSST5iuGvphEAsVW8WvRYOidch+5bZumLGrFn0uupThX3LqJz9RELxb4gG73IG2
        nq9w2PSBve4/eObFucvVi3QznUkaaNdX8f+iKNntStIynhsPCq17Q/C/WSIr1dwqN5iJf8
        oveF2osvAN/+/wdaqtdPKhG2gxih+JQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-319-mVefErXTPB24LeWDRBqEuA-1; Wed, 08 Feb 2023 11:39:55 -0500
X-MC-Unique: mVefErXTPB24LeWDRBqEuA-1
Received: by mail-ej1-f69.google.com with SMTP id ae2-20020a17090725c200b0088d91fe7ec5so13401341ejc.1
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 08:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkYkOL9mSyKYEtuavWiOPhy6b7dpdKwTrCd9LzJhy+8=;
        b=p0Y6Uu+BHmSxvtcemzJVsjB++wy14yH2RwZ9PJnwWN8Q3z3HzmSWSToutyhNK0SAGp
         PjXtSMIxzQS6/M7B5pWpLtlskIRo4kquagNK03tKRQT3UGzfXmsxjv7Z/2/MI/dpV9V4
         L3s/Ir9XpqSSnIklZPFEdjLepelNObea5Dp2RvxdWFpROVYwMCVIjZXkGAwhc+KcZxHG
         GUcDgjUpOBOjsWYldE0nfzuhTY1ARV+nXMsEKtu8Whnf63EW2Ah6g2LNEGsSpepkJkGG
         YeStriQYXqEaVMX4vdNXEwj6G8TeHcayzm7amSs8KUGeVYbm50VdVCLxlNFGIfFHhjWg
         JrHw==
X-Gm-Message-State: AO0yUKXRH2/vgwbjGTGFnBhP89xZwFCUAqPad5rk5hz1OwJht1auOVky
        W8fN31omz0LxvboQ99S8z5aEMCF9e+nFgJmNumldWcubmT3Ktr7THQvJYCub2c5WURVICDAu9jg
        1e3lrcWoVs5oX
X-Received: by 2002:a17:906:2747:b0:88d:777a:9ca6 with SMTP id a7-20020a170906274700b0088d777a9ca6mr8922959ejd.18.1675874393654;
        Wed, 08 Feb 2023 08:39:53 -0800 (PST)
X-Google-Smtp-Source: AK7set/8t5pcnjpi/TD1j5edxt/RKJH1gbwtYc60unMx5yfubJ4UtS85bbdr1pdzptlumKh3VIJ6+A==
X-Received: by 2002:a17:906:2747:b0:88d:777a:9ca6 with SMTP id a7-20020a170906274700b0088d777a9ca6mr8922919ejd.18.1675874393147;
        Wed, 08 Feb 2023 08:39:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7de8a000000b004a21c9facd5sm7989180edv.67.2023.02.08.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:39:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 300C9973CDA; Wed,  8 Feb 2023 17:39:51 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     David Vernet <void@manifault.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf/docs: Update design QA to be consistent
 with kfunc lifecycle docs
In-Reply-To: <Y+O8rJ3TGwl6FnVK@maniforge.lan>
References: <20230208135731.268638-1-toke@redhat.com>
 <Y+O8rJ3TGwl6FnVK@maniforge.lan>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 08 Feb 2023 17:39:51 +0100
Message-ID: <87y1p88620.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet <void@manifault.com> writes:

> On Wed, Feb 08, 2023 at 02:57:30PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Cong pointed out that there are some inconsistencies between the BPF des=
ign
>> QA and the lifecycle expectations documentation we added for kfuncs. Let=
's
>> update the QA file to be consistent with the kfunc docs, and add referen=
ces
>> where it makes sense. Also document that modules may export kfuncs now.
>>=20
>> v2:
>> - Fix repeated word (s/defined defined/defined/)
>>=20
>> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Thanks for fixing this. LGTM modulo one small grammar nit.
>
> Acked-by: David Vernet <void@manifault.com>

Thanks! Will fix and respin :)

-Toke

