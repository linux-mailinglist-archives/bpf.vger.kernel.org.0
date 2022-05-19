Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D60A52D92C
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbiESPuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 11:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241502AbiESPuM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 11:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77573985B6
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 08:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652975283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJJnss2EjmhKAZqfc8ROgpLfRq3oHX7787vufsfVPK0=;
        b=QCCSA1LbpxfyZ/NqJNUPcZdz9R6rFUV35YWbi+Q9zZMjqcWRLbtmXzzT9KSQa6dhYlBxlh
        8JkHSiObp0/7EtFHE4m6hIO9Z4BxulPaJ4wC+/hMmmSpvbn2OoK8FN4fC67QEYsdiQkzK8
        ziLBLVdk5CNjkguI4zW8zS1iRJdIHso=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-n-DOGQZuME26e5OuKTno8A-1; Thu, 19 May 2022 11:47:58 -0400
X-MC-Unique: n-DOGQZuME26e5OuKTno8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98652802803;
        Thu, 19 May 2022 15:47:56 +0000 (UTC)
Received: from [10.39.193.17] (unknown [10.39.193.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EC4240CF8ED;
        Thu, 19 May 2022 15:47:53 +0000 (UTC)
Message-ID: <9b03abc3-f6dc-209e-d31b-b171c5350359@redhat.com>
Date:   Thu, 19 May 2022 17:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH bpf-next v5 12/17] selftests/bpf: add tests for
 bpf_hid_hw_request
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <20220518205924.399291-1-benjamin.tissoires@redhat.com>
 <20220518205924.399291-13-benjamin.tissoires@redhat.com>
 <20220518222055.zh7hvexbqlctvotw@apollo.legion>
 <CAO-hwJLxqYC9AUrfjMX1sPdSrt7EguWt9diwadJ9UZe-XGKFJw@mail.gmail.com>
 <20220519125132.lm4ztduemzyvystf@apollo.legion>
 <1c2eb260-1437-5aa3-95af-e336019f3c49@redhat.com>
 <20220519134453.uxobs62inwoaucnk@apollo.legion>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
In-Reply-To: <20220519134453.uxobs62inwoaucnk@apollo.legion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/19/22 15:44, Kumar Kartikeya Dwivedi wrote:
> On Thu, May 19, 2022 at 06:43:41PM IST, Benjamin Tissoires wrote:
>> On 5/19/22 14:51, Kumar Kartikeya Dwivedi wrote:
>>> On Thu, May 19, 2022 at 05:42:40PM IST, Benjamin Tissoires wrote:
>>>> On Thu, May 19, 2022 at 12:20 AM Kumar Kartikeya Dwivedi
>>>> <memxor@gmail.com> wrote:
>>>>>
>>>>> On Thu, May 19, 2022 at 02:29:19AM IST, Benjamin Tissoires wrote:
>>>>>> Add tests for the newly implemented function.
>>>>>> We test here only the GET_REPORT part because the other calls are pure
>>>>>> HID protocol and won't infer the result of the test of the bpf hook.
>>>>>>
>>>>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> changes in v5:
>>>>>> - use the new hid_bpf_allocate_context() API
>>>>>> - remove the need for ctx_in for syscall TEST_RUN
>>>>>>
>>>>>> changes in v3:
>>>>>> - use the new hid_get_data API
>>>>>> - directly use HID_FEATURE_REPORT and HID_REQ_GET_REPORT from uapi
>>>>>>
>>>>>> changes in v2:
>>>>>> - split the series by bpf/libbpf/hid/selftests and samples
>>>>>> ---
>>>>>>    tools/testing/selftests/bpf/prog_tests/hid.c | 114 ++++++++++++++++---
>>>>>>    tools/testing/selftests/bpf/progs/hid.c      |  59 ++++++++++
>>>>>>    2 files changed, 155 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/hid.c b/tools/testing/selftests/bpf/prog_tests/hid.c
>>>>>> index 47bc0a30c275..54c0a0fcd54d 100644
>>>>>> --- a/tools/testing/selftests/bpf/prog_tests/hid.c
>>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/hid.c
>>>>>> @@ -77,12 +77,23 @@ static unsigned char rdesc[] = {
>>>>>>         0xc0,                   /* END_COLLECTION */
>>>>>>    };
>>>>>>
>>>>>> +static u8 feature_data[] = { 1, 2 };
>>>>>> +
>>>>>>    struct attach_prog_args {
>>>>>>         int prog_fd;
>>>>>>         unsigned int hid;
>>>>>>         int retval;
>>>>>>    };
>>>>>>
>>>>>> +struct hid_hw_request_syscall_args {
>>>>>> +     __u8 data[10];
>>>>>> +     unsigned int hid;
>>>>>> +     int retval;
>>>>>> +     size_t size;
>>>>>> +     enum hid_report_type type;
>>>>>> +     __u8 request_type;
>>>>>> +};
>>>>>> +
>>>>>>    static pthread_mutex_t uhid_started_mtx = PTHREAD_MUTEX_INITIALIZER;
>>>>>>    static pthread_cond_t uhid_started = PTHREAD_COND_INITIALIZER;
>>>>>>
>>>>>> @@ -142,7 +153,7 @@ static void destroy(int fd)
>>>>>>
>>>>>>    static int uhid_event(int fd)
>>>>>>    {
>>>>>> -     struct uhid_event ev;
>>>>>> +     struct uhid_event ev, answer;
>>>>>>         ssize_t ret;
>>>>>>
>>>>>>         memset(&ev, 0, sizeof(ev));
>>>>>> @@ -183,6 +194,15 @@ static int uhid_event(int fd)
>>>>>>                 break;
>>>>>>         case UHID_GET_REPORT:
>>>>>>                 fprintf(stderr, "UHID_GET_REPORT from uhid-dev\n");
>>>>>> +
>>>>>> +             answer.type = UHID_GET_REPORT_REPLY;
>>>>>> +             answer.u.get_report_reply.id = ev.u.get_report.id;
>>>>>> +             answer.u.get_report_reply.err = ev.u.get_report.rnum == 1 ? 0 : -EIO;
>>>>>> +             answer.u.get_report_reply.size = sizeof(feature_data);
>>>>>> +             memcpy(answer.u.get_report_reply.data, feature_data, sizeof(feature_data));
>>>>>> +
>>>>>> +             uhid_write(fd, &answer);
>>>>>> +
>>>>>>                 break;
>>>>>>         case UHID_SET_REPORT:
>>>>>>                 fprintf(stderr, "UHID_SET_REPORT from uhid-dev\n");
>>>>>> @@ -391,6 +411,7 @@ static int open_hidraw(int dev_id)
>>>>>>    struct test_params {
>>>>>>         struct hid *skel;
>>>>>>         int hidraw_fd;
>>>>>> +     int hid_id;
>>>>>>    };
>>>>>>
>>>>>>    static int prep_test(int dev_id, const char *prog_name, struct test_params *test_data)
>>>>>> @@ -419,27 +440,33 @@ static int prep_test(int dev_id, const char *prog_name, struct test_params *test
>>>>>>         if (!ASSERT_OK_PTR(hid_skel, "hid_skel_open"))
>>>>>>                 goto cleanup;
>>>>>>
>>>>>> -     prog = bpf_object__find_program_by_name(*hid_skel->skeleton->obj, prog_name);
>>>>>> -     if (!ASSERT_OK_PTR(prog, "find_prog_by_name"))
>>>>>> -             goto cleanup;
>>>>>> +     if (prog_name) {
>>>>>> +             prog = bpf_object__find_program_by_name(*hid_skel->skeleton->obj, prog_name);
>>>>>> +             if (!ASSERT_OK_PTR(prog, "find_prog_by_name"))
>>>>>> +                     goto cleanup;
>>>>>>
>>>>>> -     bpf_program__set_autoload(prog, true);
>>>>>> +             bpf_program__set_autoload(prog, true);
>>>>>>
>>>>>> -     err = hid__load(hid_skel);
>>>>>> -     if (!ASSERT_OK(err, "hid_skel_load"))
>>>>>> -             goto cleanup;
>>>>>> +             err = hid__load(hid_skel);
>>>>>> +             if (!ASSERT_OK(err, "hid_skel_load"))
>>>>>> +                     goto cleanup;
>>>>>>
>>>>>> -     attach_fd = bpf_program__fd(hid_skel->progs.attach_prog);
>>>>>> -     if (!ASSERT_GE(attach_fd, 0, "locate attach_prog")) {
>>>>>> -             err = attach_fd;
>>>>>> -             goto cleanup;
>>>>>> -     }
>>>>>> +             attach_fd = bpf_program__fd(hid_skel->progs.attach_prog);
>>>>>> +             if (!ASSERT_GE(attach_fd, 0, "locate attach_prog")) {
>>>>>> +                     err = attach_fd;
>>>>>> +                     goto cleanup;
>>>>>> +             }
>>>>>>
>>>>>> -     args.prog_fd = bpf_program__fd(prog);
>>>>>> -     err = bpf_prog_test_run_opts(attach_fd, &tattr);
>>>>>> -     snprintf(buf, sizeof(buf), "attach_hid(%s)", prog_name);
>>>>>> -     if (!ASSERT_EQ(args.retval, 0, buf))
>>>>>> -             goto cleanup;
>>>>>> +             args.prog_fd = bpf_program__fd(prog);
>>>>>> +             err = bpf_prog_test_run_opts(attach_fd, &tattr);
>>>>>> +             snprintf(buf, sizeof(buf), "attach_hid(%s)", prog_name);
>>>>>> +             if (!ASSERT_EQ(args.retval, 0, buf))
>>>>>> +                     goto cleanup;
>>>>>> +     } else {
>>>>>> +             err = hid__load(hid_skel);
>>>>>> +             if (!ASSERT_OK(err, "hid_skel_load"))
>>>>>> +                     goto cleanup;
>>>>>> +     }
>>>>>>
>>>>>>         hidraw_fd = open_hidraw(dev_id);
>>>>>>         if (!ASSERT_GE(hidraw_fd, 0, "open_hidraw"))
>>>>>> @@ -447,6 +474,7 @@ static int prep_test(int dev_id, const char *prog_name, struct test_params *test
>>>>>>
>>>>>>         test_data->skel = hid_skel;
>>>>>>         test_data->hidraw_fd = hidraw_fd;
>>>>>> +     test_data->hid_id = hid_id;
>>>>>>
>>>>>>         return 0;
>>>>>>
>>>>>> @@ -693,6 +721,54 @@ static int test_hid_change_report(int uhid_fd, int dev_id)
>>>>>>         return ret;
>>>>>>    }
>>>>>>
>>>>>> +/*
>>>>>> + * Attach hid_user_raw_request to the given uhid device,
>>>>>> + * call the bpf program from userspace
>>>>>> + * check that the program is called and does the expected.
>>>>>> + */
>>>>>> +static int test_hid_user_raw_request_call(int uhid_fd, int dev_id)
>>>>>> +{
>>>>>> +     struct test_params params;
>>>>>> +     int err, prog_fd;
>>>>>> +     int ret = -1;
>>>>>> +     struct hid_hw_request_syscall_args args = {
>>>>>> +             .retval = -1,
>>>>>> +             .type = HID_FEATURE_REPORT,
>>>>>> +             .request_type = HID_REQ_GET_REPORT,
>>>>>> +             .size = 10,
>>>>>> +     };
>>>>>> +     DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
>>>>>> +                         .ctx_in = &args,
>>>>>> +                         .ctx_size_in = sizeof(args),
>>>>>> +     );
>>>>>> +
>>>>>> +     err = prep_test(dev_id, NULL, &params);
>>>>>> +     if (!ASSERT_EQ(err, 0, "prep_test()"))
>>>>>> +             goto cleanup;
>>>>>> +
>>>>>> +     args.hid = params.hid_id;
>>>>>> +     args.data[0] = 1; /* report ID */
>>>>>> +
>>>>>> +     prog_fd = bpf_program__fd(params.skel->progs.hid_user_raw_request);
>>>>>> +
>>>>>> +     err = bpf_prog_test_run_opts(prog_fd, &tattrs);
>>>>>> +     if (!ASSERT_EQ(err, 0, "bpf_prog_test_run_opts"))
>>>>>> +             goto cleanup;
>>>>>> +
>>>>>> +     if (!ASSERT_EQ(args.retval, 2, "bpf_prog_test_run_opts_retval"))
>>>>>> +             goto cleanup;
>>>>>> +
>>>>>> +     if (!ASSERT_EQ(args.data[1], 2, "hid_user_raw_request_check_in"))
>>>>>> +             goto cleanup;
>>>>>> +
>>>>>> +     ret = 0;
>>>>>> +
>>>>>> +cleanup:
>>>>>> +     cleanup_test(&params);
>>>>>> +
>>>>>> +     return ret;
>>>>>> +}
>>>>>> +
>>>>>>    void serial_test_hid_bpf(void)
>>>>>>    {
>>>>>>         int err, uhid_fd;
>>>>>> @@ -720,6 +796,8 @@ void serial_test_hid_bpf(void)
>>>>>>         ASSERT_OK(err, "hid_attach_detach");
>>>>>>         err = test_hid_change_report(uhid_fd, dev_id);
>>>>>>         ASSERT_OK(err, "hid_change_report");
>>>>>> +     err = test_hid_user_raw_request_call(uhid_fd, dev_id);
>>>>>> +     ASSERT_OK(err, "hid_change_report");
>>>>>>
>>>>>>         destroy(uhid_fd);
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/bpf/progs/hid.c b/tools/testing/selftests/bpf/progs/hid.c
>>>>>> index ee7529c47ad8..e3444d444303 100644
>>>>>> --- a/tools/testing/selftests/bpf/progs/hid.c
>>>>>> +++ b/tools/testing/selftests/bpf/progs/hid.c
>>>>>> @@ -10,6 +10,13 @@ extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
>>>>>>                               unsigned int offset,
>>>>>>                               const size_t __sz) __ksym;
>>>>>>    extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 flags) __ksym;
>>>>>> +extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id) __ksym;
>>>>>> +extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __ksym;
>>>>>> +extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
>>>>>> +                           __u8 *data,
>>>>>> +                           size_t len,
>>>>>> +                           enum hid_report_type type,
>>>>>> +                           int reqtype) __ksym;
>>>>>>
>>>>>>    struct attach_prog_args {
>>>>>>         int prog_fd;
>>>>>> @@ -56,3 +63,55 @@ int attach_prog(struct attach_prog_args *ctx)
>>>>>>                                           0);
>>>>>>         return 0;
>>>>>>    }
>>>>>> +
>>>>>> +struct hid_hw_request_syscall_args {
>>>>>> +     /* data needs to come at offset 0 so we can do a memcpy into it */
>>>>>> +     __u8 data[10];
>>>>>> +     unsigned int hid;
>>>>>> +     int retval;
>>>>>> +     size_t size;
>>>>>> +     enum hid_report_type type;
>>>>>> +     __u8 request_type;
>>>>>> +};
>>>>>> +
>>>>>> +SEC("syscall")
>>>>>> +int hid_user_raw_request(struct hid_hw_request_syscall_args *args)
>>>>>> +{
>>>>>> +     struct hid_bpf_ctx *ctx;
>>>>>> +     int i, ret = 0;
>>>>>> +     __u8 *data;
>>>>>> +
>>>>>> +     ctx = hid_bpf_allocate_context(args->hid);
>>>>>> +     if (!ctx)
>>>>>> +             return 0; /* EPERM check */
>>>>>> +
>>>>>> +     /* We can not use the context data memory directly in the hid_bpf call,
>>>>>> +      * so we rely on the PTR_TO_MEM allocated in the hid_bpf_context
>>>>>> +      */
>>>>>> +     data = hid_bpf_get_data(ctx, 0 /* offset */, 10 /* size */);
>>>>>> +     if (!data)
>>>>>> +             goto out; /* EPERM check */
>>>>>> +
>>>>>
>>>>> If I'm reading this right, you need more than just returning PTR_TO_MEM. Since
>>>>> this points into allocated ctx, nothing prevents user from accessing data after
>>>>> we do hid_bpf_release_context.
>>>>
>>>> oops. I missed that point.
>>>>
>>>> TBH, ideally I wanted to directly pass args->data into
>>>> hid_bpf_hw_request(). But because args is seen as the context of the
>>>> program, I can not pass it to the kfunc arguments.
>>>> I would happily prevent getting a data pointer for a manually
>>>> allocated context if I could solve that issue. This would save me from
>>>> calling twice  __builtin_memcpy.
>>>
>>> Oh, is that why you need to do this? So if you were able to pass args->data, you
>>> wouldn't need this hid_bpf_get_data? kfunc does support taking PTR_TO_CTX (i.e.
>>> args in your case), I am not sure why you're not passing it in directly then.
>>> Did you encounter any errors when trying to do so? The only requirement is that
>>> args offset must be 0 (i.e. passed as is without increment).
>>
>> With the following patch applied, the tests are failing:
>> ---
>> diff --git a/tools/testing/selftests/bpf/progs/hid.c b/tools/testing/selftests/bpf/progs/hid.c
>> index 43724fd26fb9..976fc8b83934 100644
>> --- a/tools/testing/selftests/bpf/progs/hid.c
>> +++ b/tools/testing/selftests/bpf/progs/hid.c
>> @@ -80,24 +80,14 @@ int hid_user_raw_request(struct hid_hw_request_syscall_args *args)
>>   {
>>          struct hid_bpf_ctx *ctx;
>>          int i, ret = 0;
>> -       __u8 *data;
>>          ctx = hid_bpf_allocate_context(args->hid);
>>          if (!ctx)
>>                  return 0; /* EPERM check */
>> -       /* We can not use the context data memory directly in the hid_bpf call,
>> -        * so we rely on the PTR_TO_MEM allocated in the hid_bpf_context
>> -        */
>> -       data = hid_bpf_get_data(ctx, 0 /* offset */, 10 /* size */);
>> -       if (!data)
>> -               goto out; /* EPERM check */
>> -
>> -       __builtin_memcpy(data, args->data, sizeof(args->data));
>> -
>>          if (args->size <= sizeof(args->data)) {
>>                  ret = hid_bpf_hw_request(ctx,
>> -                                        data,
>> +                                        args->data,
>>                                           args->size,
>>                                           args->type,
>>                                           args->request_type);
>> @@ -109,8 +99,6 @@ int hid_user_raw_request(struct hid_hw_request_syscall_args *args)
>>                  goto out;
>>          }
>> -       __builtin_memcpy(args->data, data, sizeof(args->data));
>> -
>>    out:
>>          hid_bpf_release_context(ctx);
>> ---
>>
>> Output of the verifier:
>>
>> libbpf: prog 'hid_user_raw_request': BPF program load failed: Invalid argument
>> libbpf: prog 'hid_user_raw_request': -- BEGIN PROG LOAD LOG --
>> R1 type=ctx expected=fp
>> 0: R1=ctx(off=0,imm=0) R10=fp0
>> ; int hid_user_raw_request(struct hid_hw_request_syscall_args *args)
>> 0: (bf) r7 = r1                       ; R1=ctx(off=0,imm=0) R7_w=ctx(off=0,imm=0)
>> ; ctx = hid_bpf_allocate_context(args->hid);
>> 1: (61) r1 = *(u32 *)(r7 +12)         ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R7_w=ctx(off=0,imm=0)
>> ; ctx = hid_bpf_allocate_context(args->hid);
>> 2: (85) call hid_bpf_allocate_context#66484
>> 3: (bf) r6 = r0                       ; R0_w=ptr_or_null_hid_bpf_ctx(id=2,ref_obj_id=2,off=0,imm=0) R6_w=ptr_or_null_hid_bpf_ctx(id=2,ref_obj_id=2,off=0,imm=0) refs=2
>> 4: (b4) w8 = 0                        ; R8_w=0 refs=2
>> ; if (!ctx)
>> 5: (15) if r6 == 0x0 goto pc+12       ; R6_w=ptr_hid_bpf_ctx(ref_obj_id=2,off=0,imm=0) refs=2
>> 6: (b4) w8 = -7                       ; R8_w=4294967289 refs=2
>> ; if (args->size <= sizeof(args->data)) {
>> 7: (79) r3 = *(u64 *)(r7 +24)         ; R3=scalar() R7=ctx(off=0,imm=0) refs=2
>> ; if (args->size <= sizeof(args->data)) {
>> 8: (25) if r3 > 0xa goto pc+7         ; R3=scalar(umax=10,var_off=(0x0; 0xf)) refs=2
>> ; args->request_type);
>> 9: (71) r5 = *(u8 *)(r7 +36)          ; R5_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ctx(off=0,imm=0) refs=2
>> ; args->type,
>> 10: (61) r4 = *(u32 *)(r7 +32)        ; R4_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R7=ctx(off=0,imm=0) refs=2
>> ; ret = hid_bpf_hw_request(ctx,
>> 11: (bf) r1 = r6                      ; R1_w=ptr_hid_bpf_ctx(ref_obj_id=2,off=0,imm=0) R6=ptr_hid_bpf_ctx(ref_obj_id=2,off=0,imm=0) refs=2
>> 12: (bf) r2 = r7                      ; R2_w=ctx(off=0,imm=0) R7=ctx(off=0,imm=0) refs=2
>> 13: (85) call hid_bpf_hw_request#66480
>> R2 type=ctx expected=fp
>> processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
>> -- END PROG LOAD LOG --
>>
>> Maybe I am wrongly declaring hid_bpf_hw_request()?
>>
> 
> Ah, I see. This is because current code does not handle syscall prog. We need to
> teach bpf_get_prog_ctx_type to handle this case for BPF_PROG_TYPE_SYSCALL. We
> can use the ctx size at verification time, we will have to ensure the size is
> greater than or equal to the size of struct expected by hid_bpf_hw_request for
> that arg. Currently the type of ctx is void * for syscall progs, which obviously
> is indicating lack of known size of ctx at compile time.
> 
> In your case, you have a pair of args that pass a certain size while expecting
> ctx as data of some len. For these variable sized ctx, we should probably just
> make kfunc define void *, len__ctx_sz (__ctx_sz suffix) pair of args. If it sees
> void * as arg type and as ctx as pointer type, it tries to check if arguments
> are set up like this. Probably only makes sense doing for syscall progs since
> ctx is user supplied. You can look at existing handling for __sz suffix for
> inspiration.
> 

OK, so I think I understand now why it fails. Thanks.

However, I'd like to not restrict the void * argument to a context, as
users might want to simply statically allocate a buffer and use that.

What if I do the following? (by changing return 0 to something
meaningfull):

---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 084319073064..8d5b47af0da5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5020,6 +5020,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
                                    struct bpf_call_arg_meta *meta)
  {
         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+       enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
         u32 *max_access;
  
         switch (base_type(reg->type)) {
@@ -5073,6 +5074,14 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
                                 env,
                                 regno, reg->off, access_size,
                                 zero_size_allowed, ACCESS_HELPER, meta);
+       case PTR_TO_CTX:
+               /* in case of type SYSCALL, the context is user supplied so
+                * not computed statically.
+                * Dynamically check it now
+                */
+               if (prog_type == BPF_PROG_TYPE_SYSCALL)
+                       return 0 /* some magic call to compare the access_size against the ctx size */;
+               fallthrough;
         default: /* scalar_value or invalid ptr */
                 /* Allow zero-byte read from NULL, regardless of pointer type */
                 if (zero_size_allowed && access_size == 0 &&
---

Would I be able to get access to the real CTX size there, and would that be acceptable?

Cheers,
Benjamin

PS: I'll be out tomorrow and it's the end of the work day here, so I might not answer before next Monday

>> Cheers,
>> Benjamin
>>
>>>
>>>>
>>>> That doesn't change the fact that you are correct and the PTR_TO_MEM
>>>> in kfunc code should be fixed.
>>>> But right now, I am not sure what you mean below and I'll need a
>>>> little bit more time to process it.
>>>>
>>>> Cheers,
>>>> Benjamin
>>>>
>>>>>
>>>>> The ref_obj_id of ctx needs to be transferred to R0.ref_obj_id, and R0.id needs
>>>>> to be assigned another id distinct from the ref_obj_id.
>>>>>
>>>>> My idea would be to give this type of function a new set, and handle this case
>>>>> of transferring ref_obj_id into R0. See is_ptr_cast_function in verifier.c.
>>>>> Shouldn't be too much code. You could even use the bpf_kfunc_arg_meta to store
>>>>> the ref_obj_id (and ensure only one referenced register exists among the 5
>>>>> arguments).
>>>>>
>>>>>> +     __builtin_memcpy(data, args->data, sizeof(args->data));
>>>>>> +
>>>>>> +     if (args->size <= sizeof(args->data)) {
>>>>>> +             ret = hid_bpf_hw_request(ctx,
>>>>>> +                                      data,
>>>>>> +                                      args->size,
>>>>>> +                                      args->type,
>>>>>> +                                      args->request_type);
>>>>>> +             args->retval = ret;
>>>>>> +             if (ret < 0)
>>>>>> +                     goto out;
>>>>>> +     } else {
>>>>>> +             ret = -7; /* -E2BIG */
>>>>>> +             goto out;
>>>>>> +     }
>>>>>> +
>>>>>> +     __builtin_memcpy(args->data, data, sizeof(args->data));
>>>>>> +
>>>>>> + out:
>>>>>> +     hid_bpf_release_context(ctx);
>>>>>> +
>>>>>> +     return ret;
>>>>>> +}
>>>>>> --
>>>>>> 2.36.1
>>>>>>
>>>>>
>>>>> --
>>>>> Kartikeya
>>>>>
>>>>
>>>
>>> --
>>> Kartikeya
>>>
>>
> 
> --
> Kartikeya
> 

