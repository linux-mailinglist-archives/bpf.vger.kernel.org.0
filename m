Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F7F5A0446
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiHXWui (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiHXWuh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:50:37 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF087255B2;
        Wed, 24 Aug 2022 15:50:25 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11c5ee9bf43so22713658fac.5;
        Wed, 24 Aug 2022 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:to:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=cVr7EjOeuA4Iq3LSWg/NF5BMsUxiamTOQ8MK4OLgi5A=;
        b=nNyX2ow2/eL3/m+b7YveC0PUvcu85t8FAYoQJeyo4pjFYC3BgnBhVcgha0RiomkhL4
         cJRyVAIJjicbo5rq5Cb8BNyLEB1x2QYc1d0HK53hgnlfylXv6nxtkoI9PBl/iFnH4fkp
         r41NDgYtm3H03TKqRNafdKJFEP8Fd6BdbHdcZ4mVfANk3ZdAJNnTh3uV4gFQnDWNEu9t
         32txW8NLHmKSBWBdCTaNHA60csUGyrmnxRwl8svG2qEcDMj4PC5vl2eIKl/u3ddAJbWW
         D6IQuxLUvB4VbbP611dSbKyDnYpgY/jiHnDDy9hy7yM8GXHJ+28/mFjjKzYUoeG9nfS1
         U/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:to:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cVr7EjOeuA4Iq3LSWg/NF5BMsUxiamTOQ8MK4OLgi5A=;
        b=L2e6HVGwSmQpDVK8VtoA31xJtqLPD6zf2/C0yPD4Pb3RQktDg1BpdZ6FTo7NOQZO1u
         lhNyEP37p7AB6zBfae9N5iQoxvmNrChYHKq0bkoTvQxpNfDHz1uj9riQ6enaQqXViEBw
         UiTGOAlEXJU9mazx2YRH1bw5y/NzPa6lRIb52Grd2VYp0PW7jwGVVjm4uSZpRCLqLfGU
         ouGn7MeiNUGh0VarDm8uutb0AK/m0Y8IHOlOQ3DlVp2V5OnxX7XHK7c8XC0m/f/AG2oS
         l2/65+1FkG32cGOWQCikOh9GgEWrIge692CN3PpgNdEPQTFG+vfUNhB4fiE3femlmHrx
         c6Vw==
X-Gm-Message-State: ACgBeo2JY+N2hmP4a1pqO3eLGLwbmo0R+eGEb2K5x4kExFxY+zuurk2E
        auFgRP4Z6a21DAGmPrbiAEI=
X-Google-Smtp-Source: AA6agR4iB0qmWLoxnq0qCvKQTADtks334bZv3oLhLSmgujmQ+lM4RVGM1qXSyQY3ytjuSDPFVxFYGQ==
X-Received: by 2002:a05:6870:1601:b0:108:2d92:5494 with SMTP id b1-20020a056870160100b001082d925494mr4848157oae.109.1661381425274;
        Wed, 24 Aug 2022 15:50:25 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id ay19-20020a056808301300b00342e8bd2299sm4298699oib.6.2022.08.24.15.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 15:50:24 -0700 (PDT)
Message-ID: <538ebda0-0f8a-ebae-f02f-c8f8736ca12b@gmail.com>
Date:   Wed, 24 Aug 2022 19:50:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: ANNOUNCE: pahole v1.24 (Faster BTF encoding, 64-bit BTF enum
 entries)
Content-Language: en-US
References: <YwQRKkmWqsf/Du6A@kernel.org>
 <CADo9pHhW9w+ciNbQr+7u4mezuQ1USyh0k2Wshy=wkdEcxRiDLA@mail.gmail.com>
 <YwY2mFuJP10dehRx@kernel.org>
 <CADo9pHheRprMRAZkcxcALRv7gi8r+_CpNBP+LB4rt0n-_ZMQ4Q@mail.gmail.com>
 <YwY3qEa2gFsPg2jz@kernel.org>
 <CADo9pHhcw2+WEYfD=hJ-o67fw9Uf+ERS8xo2SHApNQgPwGCmBA@mail.gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Luna Jernberg <droidbittin@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
From:   Martin Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CADo9pHhcw2+WEYfD=hJ-o67fw9Uf+ERS8xo2SHApNQgPwGCmBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/24/22 11:38, Luna Jernberg wrote:
> https://forum.endeavouros.com/t/failed-to-start-load-kernel-modules-on-boot-after-system-update-nvidia/30584/17?u=sradjoker
> 
> On 8/24/22, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
>> Em Wed, Aug 24, 2022 at 04:36:18PM +0200, Luna Jernberg escreveu:
>>> The Nvidia driver breaks
>>
>> How? What are the messages?
>>
>> Here is a test on an Archlinux container:
>>
>> [perfbuilder@758097c04011 dwarves-1.24]$ pahole --version
>> v1.24
>> [perfbuilder@758097c04011 dwarves-1.24]$ cat /etc/os-release
>> NAME="Arch Linux"
>> PRETTY_NAME="Arch Linux"
>> ID=arch
>> BUILD_ID=rolling
>> VERSION_ID=TEMPLATE_VERSION_ID
>> ANSI_COLOR="38;2;23;147;209"
>> HOME_URL="https://archlinux.org/"
>> DOCUMENTATION_URL="https://wiki.archlinux.org/"
>> SUPPORT_URL="https://bbs.archlinux.org/"
>> BUG_REPORT_URL="https://bugs.archlinux.org/"
>> LOGO=archlinux-logo
>> [perfbuilder@758097c04011 dwarves-1.24]$ pahole list_head
>> struct list_head {
>> 	struct list_head *         next;                 /*     0     8 */
>> 	struct list_head *         prev;                 /*     8     8 */
>>
>> 	/* size: 16, cachelines: 1, members: 2 */
>> 	/* last cacheline: 16 bytes */
>> };
>> [perfbuilder@758097c04011 dwarves-1.24]$ pahole --sizes | sort -k2 -nr |
>> head
>> rcu_state	300608	7
>> cmp_data	290904	1
>> dec_data	274520	1
>> cpu_entry_area	241664	0
>> kvm	190016	6
>> pglist_data	173440	6
>> ZSTD_DCtx_s	161480	6
>> saved_cmdlines_buffer	131104	1
>> debug_store_buffers	131072	0
>> hid_parser	110848	1
>> [perfbuilder@758097c04011 dwarves-1.24]$
>>
>>> On 8/24/22, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
>>>> Em Wed, Aug 24, 2022 at 03:23:29PM +0200, Luna Jernberg escreveu:
>>>>> This package breaks on Arch Linux at the moment and if you are using
>>>>> Arch
>>>>> its recommended that you downgrade to 1.23
>>>>
>>>> Breaks in what sense? Can you please provide details?
>>>>
>>>> - Arnaldo
>>>>
>>>>> On Tue, Aug 23, 2022 at 1:59 AM Arnaldo Carvalho de Melo
>>>>> <acme@kernel.org>
>>>>> wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>>         The v1.24 release of pahole and its friends is out, with
>>>>>> faster
>>>>>> BTF generation by parallelizing the encoding part in addition to the
>>>>>> previoulsy parallelized DWARF loading, support for 64-bit BTF
>>>>>> enumeration
>>>>>> entries, signed BTF encoding of 'char', exclude/select DWARF loading
>>>>>> based on the language that generated the objects, etc.
>>>>>>
>>>>>> Main git repo:
>>>>>>
>>>>>>    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
>>>>>>
>>>>>> Mirror git repo:
>>>>>>
>>>>>>    https://github.com/acmel/dwarves.git
>>>>>>
>>>>>> tarball + gpg signature:
>>>>>>
>>>>>>    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.xz
>>>>>>    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.bz2
>>>>>>    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.sign
>>>>>>
>>>>>>         Thanks a lot to all the contributors and distro packagers,
>>>>>> you're
>>>>>> on the
>>>>>> CC list, I appreciate a lot the work you put into these tools,
>>>>>>
>>>>>> Best Regards,
>>>>>>
>>>>>> BTF encoder:
>>>>>>
>>>>>> - Add support to BTF_KIND_ENUM64 to represent enumeration entries
>>>>>> with
>>>>>>   more than 32 bits.
>>>>>>
>>>>>> - Support multithreaded encoding, in addition to DWARF multithreaded
>>>>>>   loading, speeding up the process.
>>>>>>
>>>>>>   Selected just like DWARF multithreaded loading, using the 'pahole
>>>>>> -j'
>>>>>>   option.
>>>>>>
>>>>>> - Encode 'char' type as signed.
>>>>>>
>>>>>> BTF Loader:
>>>>>>
>>>>>> - Add support to BTF_KIND_ENUM64.
>>>>>>
>>>>>> pahole:
>>>>>>
>>>>>> - Introduce --lang and --lang_exclude to specify the language the
>>>>>>   DWARF compile units were originated from to use or filter.
>>>>>>
>>>>>>   Use case is to exclude Rust compile units while aspects of the
>>>>>>   DWARF generated for it get sorted out in a way that the kernel
>>>>>>   BPF verifier don't refuse loading the BTF generated from them.
>>>>>>
>>>>>> - Introduce --compile to generate compilable code in a similar
>>>>>> fashion
>>>>>> to:
>>>>>>
>>>>>>    bpftool btf dump file vmlinux format c > vmlinux.h
>>>>>>
>>>>>>   As with 'bpftool', this will notice type shadowing, i.e. multiple
>>>>>> types
>>>>>>   with the same name and will disambiguate by adding a suffix.
>>>>>>
>>>>>> - Don't segfault when processing bogus files.
>>>>>>
>>>>
>>>> --
>>>>
>>>> - Arnaldo
>>>>
>>
>> --
>>
>> - Arnaldo
>>

Can you try a build of the kernel or the by passing the
--skip_encoding_btf_enum64 to scripts/pahole-flags.sh?

Here's a patch for either in tree scripts/pahole-flags.sh or
/usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 0d99ef17e4a528..1f1f1d397c399a 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -19,5 +19,9 @@ fi
 if [ "${pahole_ver}" -ge "122" ]; then
 	extra_paholeopt="${extra_paholeopt} -j"
 fi
+if [ "${pahole_ver}" -ge "124" ]; then
+	# see PAHOLE_HAS_LANG_EXCLUDE
+	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_enum64"
+fi

 echo ${extra_paholeopt}

- Martin Rodriguez Reboredo
