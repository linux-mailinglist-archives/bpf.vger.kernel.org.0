Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51AF586B69
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 14:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiHAM4I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 08:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiHAMzX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 08:55:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37755B1C9
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 05:52:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk11so4149412wrb.10
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EA9QdWUPQLebun95Yvb2w5eAjImMjoWwRIL2xCCGqBk=;
        b=pHGZxjMnbOZWLDkSmZ0T0pIJjfVudZhaE09Qq+lJRNHvSs76C3+Ctw7DRw/ifF2a3F
         cQQchBuUd5uey+v6/2Ki67lYkpCiQGxbmSNILr1UywbZffATBYpc5Bxv1gQtV06jdBxb
         0UK3mbRBNPlYRRah/WW5Vy8N8l0V1lTt17opRt/8Oju2m0MRUyvh1rIxwAacoQAH79xm
         zpzdZ6bM3g6cDCfu2G6KF0XT+b59kmqgSi3UnyKYf6wvh77PGAEACuNdLrnlLPZmVmLF
         Lqjc7CG5mk9mcQFurO4LyXilEPYEoNzgbqgOgPT9KMxcjvmAhIqhYIHpsmGN6uWBWB8O
         kV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EA9QdWUPQLebun95Yvb2w5eAjImMjoWwRIL2xCCGqBk=;
        b=ubVz8Tp1Ilg1hkt59m6C/3hYQ2ET2c8YEmvFBnd+V2J5MTJChvXYCbaH1dfmpxGWIa
         cY7vvl9bmwZblSrwfxckh+3jvefYj/keA0j2rUISlk+LOAu7Rini6PzfblI9GMEl25oV
         C6JxyY+BOgxnbtsn4jylSAUM5l2FTAixV2QrKFPkamuQTNijix555Frk2eWfv/s0+OPo
         bIcBekqjcLi8F7mfVMLUCPDiYC0yHLeSJU+MY8N715JfXPAyek9S0Lm5Kw4P5C4qdQvq
         JC6twR/cpqDS98OGMLg20FKLjNaEwtQdkgYehSNrgjmoRTAEt6T8AQAboOaNCsBcmOcd
         Zgzg==
X-Gm-Message-State: ACgBeo108N6j+UPF6uCQhSVjE8DHTuCnoflwaO12Ikqq89nBiLIwOYhw
        n1y6/MOluQPyX5AYsMdSISfvORNnMZQJHED4
X-Google-Smtp-Source: AA6agR6NGZ8h1WcSQqzy2cRSkPcIuS884xUpzp7Wx5IQwbqKXxCAjoeJHtJ7WRY90nTO3g1bSjoA0A==
X-Received: by 2002:adf:d1c4:0:b0:21e:98d2:bd87 with SMTP id b4-20020adfd1c4000000b0021e98d2bd87mr10482638wrd.56.1659358349759;
        Mon, 01 Aug 2022 05:52:29 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id r41-20020a05600c322900b003a2e89d1fb5sm17964017wmp.42.2022.08.01.05.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 05:52:29 -0700 (PDT)
Message-ID: <d6b849a7-6930-f484-d042-a5a47d44317c@isovalent.com>
Date:   Mon, 1 Aug 2022 13:52:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH bpf-next v2] bpftool: Remove BPF_OBJ_NAME_LEN restriction
 when looking up bpf program by name
Content-Language: en-GB
To:     Manu Bretelle <chantr4@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
References: <20220731181007.3130320-1-chantr4@gmail.com>
 <98f6a795-50dc-e6d2-87ee-8fafc7e1ee7b@isovalent.com>
 <CAArYzrLEcFCZhCm_ap-FYBzPquzmwdwiejJsR7Uqd7omDG-iuA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAArYzrLEcFCZhCm_ap-FYBzPquzmwdwiejJsR7Uqd7omDG-iuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/08/2022 13:39, Manu Bretelle wrote:
> On Mon, Aug 1, 2022 at 5:18 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> On 31/07/2022 19:10, Manu Bretelle wrote:
>>> bpftool was limiting the length of names to BPF_OBJ_NAME_LEN in prog_parse
>>> fds.
>>>
>>> Since commit b662000aff84 ("bpftool: Adding support for BTF program names")
>>> we can get the full program name from BTF.
>>>
>>> This patch removes the restriction of name length when running `bpftool
>>> prog show name ${name}`.
>>>
>>> Test:
>>> Tested against some internal program names that were longer than
>>> `BPF_OBJ_NAME_LEN`, here a redacted example of what was ran to test.
>>>
>>>     # previous behaviour
>>>     $ sudo bpftool prog show name some_long_program_name
>>>     Error: can't parse name
>>>     # with the patch
>>>     $ sudo ./bpftool prog show name some_long_program_name
>>>     123456789: tracing  name some_long_program_name  tag taghexa  gpl ....
>>>     ...
>>>     ...
>>>     ...
>>>     # too long
>>>     sudo ./bpftool prog show name $(python3 -c 'print("A"*128)')
>>>     Error: can't parse name
>>>     # not too long but no match
>>>     $ sudo ./bpftool prog show name $(python3 -c 'print("A"*127)')
>>>
>>> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
>>>
>>> ---
>>>
>>> v1 -> v2:
>>> * Fix commit message to follow patch submission guidelines
>>> * use strncmp instead of strcmp
>>> * reintroduce arg length check against MAX_PROG_FULL_NAME
>>>
>>>
>>>  tools/bpf/bpftool/common.c | 15 ++++++++++++---
>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
>>> index 067e9ea59e3b..3ea747b3b194 100644
>>> --- a/tools/bpf/bpftool/common.c
>>> +++ b/tools/bpf/bpftool/common.c
>>> @@ -722,6 +722,7 @@ print_all_levels(__maybe_unused enum libbpf_print_level level,
>>>
>>>  static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
>>>  {
>>> +     char prog_name[MAX_PROG_FULL_NAME];
>>>       unsigned int id = 0;
>>>       int fd, nb_fds = 0;
>>>       void *tmp;
>>> @@ -754,12 +755,20 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
>>>                       goto err_close_fd;
>>>               }
>>>
>>> -             if ((tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) ||
>>> -                 (!tag && strncmp(nametag, info.name, BPF_OBJ_NAME_LEN))) {
>>> +             if (tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) {
>>>                       close(fd);
>>>                       continue;
>>>               }
>>>
>>> +             if (!tag) {
>>> +                     get_prog_full_name(&info, fd, prog_name,
>>> +                             sizeof(prog_name));
>>
>> Nit: This line should be aligned with the opening parenthesis from the
>> line above, checkpatch.pl complains about it. Probably not worth sending
>> a new version just for that, though.
> 
> Yeah, I saw that on patchwork. For some reason, the `checkpatch.pl`
> version I had from bpf-next tree did not catch this.

It's because it's a low-level issue: a “check” for checkpatch, not a
“warning” or an “error”. Checkpatch will only report this if you run it
with "--strict", which the CI does.

> Originally, I was getting an error because it was more than 75 char
> long. Eventually found out that shiftwidth should have been set to 8
> (mine was 4).
> I am happy to provide a corrected version if you want, this is really
> just a matter of a minute now that I have the right vim indentation
> setting.

OK let's do this. Please keep my Reviewed-by on v3.

