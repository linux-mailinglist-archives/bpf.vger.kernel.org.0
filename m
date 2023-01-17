Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0849F66E206
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjAQPYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 10:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjAQPX6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 10:23:58 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BA43524C
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 07:23:17 -0800 (PST)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pHnnj-0003Gl-17; Tue, 17 Jan 2023 16:23:03 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pHnni-000DZV-Hb; Tue, 17 Jan 2023 16:23:02 +0100
Subject: Re: [RFC PATCH bpf-next] Documentation/bpf: Add a description of
 "stable kfuncs"
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20230116225724.377099-1-toke@redhat.com>
 <6deb800f-57d8-9ee5-d588-ee6354e74aa9@iogearbox.net> <87fsc9csa5.fsf@toke.dk>
 <bb5b4544-7011-ecca-5d10-cb7c6e72f181@iogearbox.net> <87cz7dcpvy.fsf@toke.dk>
 <aaa31102-7ac9-0b39-b545-a51352deaf27@iogearbox.net> <874jspcjk8.fsf@toke.dk>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <21baf37f-32a1-69cb-bf3d-afe253bd8243@iogearbox.net>
Date:   Tue, 17 Jan 2023 16:23:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <874jspcjk8.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26784/Tue Jan 17 09:29:12 2023)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/17/23 3:38 PM, Toke Høiland-Jørgensen wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
>> On 1/17/23 1:22 PM, Toke Høiland-Jørgensen wrote:
>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>> On 1/17/23 12:30 PM, Toke Høiland-Jørgensen wrote:
>>>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>>>> On 1/16/23 11:57 PM, Toke Høiland-Jørgensen wrote:
>>>>>>> Following up on the discussion at the BPF office hours, this patch adds a
>>>>>>> description of the (new) concept of "stable kfuncs", which are kfuncs that
>>>>>>> offer a "more stable" interface than what we have now, but is still not
>>>>>>> part of UAPI.
>>>>>>>
>>>>>>> This is mostly meant as a straw man proposal to focus discussions around
>>>>>>> stability guarantees. From the discussion, it seemed clear that there were
>>>>>>> at least some people (myself included) who felt that there needs to be some
>>>>>>> way to export functionality that we consider "stable" (in the sense of
>>>>>>> "applications can rely on its continuing existence").
>>>>>>>
>>>>>>> One option is to keep BPF helpers as the stable interface and implement
>>>>>>> some technical solution for moving functionality from kfuncs to helpers
>>>>>>> once it has stood the test of time and we're comfortable committing to it
>>>>>>> as a stable API. Another is to freeze the helper definitions, and instead
>>>>>>> use kfuncs for this purpose as well, by marking a subset of them as
>>>>>>> "stable" in some way. Or we can do both and have multiple levels of "stable",
>>>>>>> I suppose.
>>>>>>>
>>>>>>> This patch is an attempt to describe what the "stable kfuncs" idea might look
>>>>>>> like, as well as to formulate some criteria for what we mean by "stable", and
>>>>>>> describe an explicit deprecation procedure. Feel free to critique any part
>>>>>>> of this (including rejecting the notion entirely).
>>>>>>>
>>>>>>> Some people mentioned (in the office hours) that should we decide to go in
>>>>>>> this direction, there's some work that needs to be done in libbpf (and
>>>>>>> probably the kernel too?) to bring the kfunc developer experience up to par
>>>>>>> with helpers. Things like exporting kfunc definitions to vmlinux.h (to make
>>>>>>> them discoverable), and having CO-RE support for using them, etc. I kinda
>>>>>>> consider that orthogonal to what's described here, but I added a
>>>>>>> placeholder reference indicating that this (TBD) functionality exists.
>>>>>>
>>>>>> Thanks for the writeup.. I did some edits to your sections to make some parts
>>>>>> more clear and to leave out other parts (e.g. libbpf-related bits which are not
>>>>>> relevant in here and it's one of many libs). I also edited some parts to leave
>>>>>> us more flexibility. Here would be my take mixed in:
>>>>>
>>>>> Edits LGTM, with just one nit, below:
>>>>>
>>>>>> 3. API (in)stability of kfuncs
>>>>>> ==============================
>>>>>>
>>>>>> By default, kfuncs exported to BPF programs are considered a kernel-internal
>>>>>> interface that can change between kernel versions. In the extreme case that
>>>>>> could also include removal of a kfunc. This means that BPF programs using
>>>>>> kfuncs might need to adapt to changes between kernel versions. In other words,
>>>>>> kfuncs are _not_ part of the kernel UAPI! Rather, these kfuncs can be thought
>>>>>> of as being similar to internal kernel API functions exported using the
>>>>>> ``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functionality must
>>>>>> initially start out as kfuncs.
>>>>>>
>>>>>> 3.1 Promotion to "stable"
>>>>>> -------------------------
>>>>>>
>>>>>> While kfuncs are by default considered unstable as described above, some kfuncs
>>>>>> may warrant a stronger stability guarantee and could be marked as *stable*. The
>>>>>> decision to move a kfunc to *stable* is taken on a case-by-case basis and has
>>>>>> a high barrier, taking into account its usefulness under longer-term production
>>>>>> deployment without any unforeseen API issues or limitations. In general, it is
>>>>
>>>> Forgot, we should probably also add after "[...] or limitations.":
>>>>
>>>>      Such promotion request along with aforementioned argumentation on why a kfunc
>>>>      is ready to be stabilized must be driven from developer-side.
>>>
>>> What does "driven from developer-side" mean, exactly? And what kind of
>>> developers (BPF app developers, or kernel devs)?
>>
>> Mainly to denote that this needs to be an explicit request from the community
>> rather than something that would happen automagically after some time (e.g.
>> where maintainers would just put the KF_STABLE stamp to it). 'kfunc xyz has
>> been used in our fleet in production in the context of project abc for two
>> years now and its API is sufficient to cover all foreseeable needs. The
>> kfunc didn't need to get extended since it was added [...]', for example.
>> The developer-hat can be both as long as there is a concrete relation to
>> usage of the kfunc that can be provided to then make the case.
> 
> Right, makes sense! So how about:
> 
> "The process for requesting a kfunc be marked as stable consists of
> submitting a patch to the bpf@vger.kernel.org mailing list adding the
> KF_STABLE tag to that kfunc's definition. The patch description must
> include the rationale for why the kfunc should be promoted to stable,
> including references to existing production uses, etc."

Sounds good to me!

Thanks,
Daniel
