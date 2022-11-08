Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4A6620CE0
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 11:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiKHKIl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 05:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiKHKIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 05:08:39 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD7DF41;
        Tue,  8 Nov 2022 02:08:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 187-20020a1c02c4000000b003cf9c3f3b80so3840319wmc.0;
        Tue, 08 Nov 2022 02:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bSP5rAO6sHTJ2bukwiH6Eo4ecQOB97Mkipf0CMrg3Cw=;
        b=nUHHAbMEVjIySvRGca9gO5+3wbwCq4e/GeIJoDtCpcB1ss1b4qRw5qzQbmdHsqvZMr
         bSsSQ2RJunaSytJ5LhOmqeqwg7BEANwSMaRj+p5x0kVQTX4lSLeqb9t5UeKai5Bz9wLW
         Tvx1AzPLlceh/mcmhmrrtKlQrnnxdIFU+3PfwSdY+rxFc2gWzC7IW1b95UqZk2HSaa0f
         GQ4XzgsyjSuPA7XFZvz86VbHLDkHSb5j4jvVgBQS0mWJ/krLoZ0KITm14UlW78yE39Rd
         iCuIq8scnBRqn3FLJTX9lQAVln2b5aLzS4GZYk/rtWDvEWMEn882mCzSaPcpFhJoJbYR
         qiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSP5rAO6sHTJ2bukwiH6Eo4ecQOB97Mkipf0CMrg3Cw=;
        b=Jr98F701nZ0ov0qOELcu6TJHZH1qt1+NIIKwuUmMYnDnKutV7+n/TCloJKG/E6Xq8H
         YH4qtikm0bB9D4uGEhrUu/NDrrqlPdFeWFi2JECAxZLqQFpDcd7V9zXH+aoup3X0tqvu
         7Nk4Gjl8T89Cs8SsjVf1yXnEyxG12Nq1hWp2HLG1tGsPkVoeJjQZdQuVmDWlQgcgXn/M
         moYtelXeHyGT8bVV1s+rNtM9WEb065hJT/MbNxpnjWvMhWawgNaz89bdK0Elpn6BlhdE
         HfH39uUJ3kCpWhxaVS9oIY71JI0V/EQkckdN/Zl2U8IdrOlg+zF9PwZhZrpKN6QdJ5JN
         779w==
X-Gm-Message-State: ACrzQf1IoVPPhUtTuZcubFDcxoIKJPWiGqM4W5jF7zrF2/d34V9WRz7e
        4nIs0VRNc+3xwQ4pLeEV4aA=
X-Google-Smtp-Source: AMsMyM6VP5pIpdAEb5HD+K54UgJ6Iailantpgu6jCvO/YWGxpU+tXPXwpZm609gGBxl7csXN1lqSAw==
X-Received: by 2002:a05:600c:3208:b0:3cf:92a6:30b4 with SMTP id r8-20020a05600c320800b003cf92a630b4mr16522963wmp.148.1667902116364;
        Tue, 08 Nov 2022 02:08:36 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:550:1196:18a3:8071])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c3b8c00b003c6bd91caa5sm11729514wms.17.2022.11.08.02.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 02:08:35 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maryam Tahhan <mtahhan@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next v3] docs/bpf: document BPF ARRAY_OF_MAPS and
 HASH_OF_MAPS
In-Reply-To: <ad5e6435-30d6-afa3-ab4a-5cc6767a0f09@meta.com> (Yonghong Song's
        message of "Mon, 7 Nov 2022 11:41:09 -0800")
Date:   Tue, 08 Nov 2022 10:00:19 +0000
Message-ID: <m2a651sr4c.fsf@gmail.com>
References: <20221107134840.92633-1-donald.hunter@gmail.com>
        <1ef036ac-1499-ae14-0ceb-997fa03db509@meta.com>
        <ad5e6435-30d6-afa3-ab4a-5cc6767a0f09@meta.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@meta.com> writes:

> On 11/7/22 9:46 AM, Yonghong Song wrote:
>> On 11/7/22 5:48 AM, Donald Hunter wrote:
>>> +
>>> +The outer map supports element update and delete from user space using=
 the
>>> +syscall API. A BPF program is only allowed to do element lookup in the=
 outer
>>> +map.
>> The outer map supports element lookup, update and delete from user space=
 using the syscall
>> API.
>> A BPF program can do element delete for array/hash_of_maps. Please doubl=
e check.
>
> Okay, I double checked with verifier.c. You are right, only lookup
> is supported for bpf programs.

Thanks for checking. I do refer to verifier.c to see what helpers are
supported. I will add lookup for userspace.

>>> +
>>> +See ``progs/test_bpf_map_in_map.c`` in ``tools/testing/selftests/bpf``=
 for more
>> The file name test_bpf_map_in_map.c` does not exist.

Good catch, that's an unfortunate typo. It should be test_btf_map_in_map.c

>>> +examples of declarative initialisation of outer maps.
>>> +
>>> +User Space
>>> +----------
>>> +
>>> +This snippet shows how to create an array based outer map:
>>> +
>>> +.. code-block:: c
>>> +
>>> +=C2=A0=C2=A0=C2=A0 int create_outer_array(int inner_fd) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=
 fd;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LIB=
BPF_OPTS(bpf_map_create_opts, opts, .inner_map_fd =3D inner_fd);
>> This is declaration. Please put it adjacent to 'int fd'.

Will do. Looking at code in testing/selftests/bpf it seems the preferred st=
yle
is to put it above 'int fd;' ?
