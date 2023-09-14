Return-Path: <bpf+bounces-10097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7383E7A1085
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 00:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454DB1C212AD
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 22:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AC5273CF;
	Thu, 14 Sep 2023 22:08:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5CE26E2B
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 22:07:57 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6932120;
	Thu, 14 Sep 2023 15:07:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502e6d632b6so2067570e87.0;
        Thu, 14 Sep 2023 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694729275; x=1695334075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J4q0+KdDAZAeHuv5SQDcYCznLrz2DzxrJOh/rOnJn4=;
        b=jP6ls/ygQeI+tdqXZHZE1t7MUS/CT+fU9mGpgrxbbyNoNLmuEXULuLK4X3tKRM546V
         duGoR+uECvgTn7III38oFGHn+tx/XC9Q6XgRSEfErPZw+xvgET0eVEYAdH6ZbJDuJEKn
         XnQmZAcFS4T2xQXLJqXH4MraHe4Q6qxVtYrm+/xY3y4HjL2MmrEUPBwMIWRspYI1r9Sf
         jpfp5pShlozsDvV/LzQNzmZOAPCeA3Zig6yCbUtPrIIOKYYAyJiq5VvaEpakgEJ3D3sI
         d0bi5mWqqCH70l1Llx2s2zLYq1Xv+fVg7hreOlFHaWDI0qCIs8MMYyGf9Gtspogj1F80
         M/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694729275; x=1695334075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J4q0+KdDAZAeHuv5SQDcYCznLrz2DzxrJOh/rOnJn4=;
        b=VXoeXCM3TP74A2fJSk1ojzWmWEaH0fDegBYB7dZeWLKmehIkNptryTugn1Vat78vv4
         aaaNCgX7+oy3L9pIKE04Oc0rBp1JiscCI8k5TRunrFVV3UYUBGuKdS/Uym4t4+xB2lcU
         JxyJcNGiWmpYkXonFJnSrEC5HDnTkV+3Hvil06NgkpZIBM+InetWvjZVsS32IUHesaVL
         ntW423cYNVIvfR0OZVYyTUOZo8/pCKSPh0pUqK3k3VSra2FgnWiNeQo8V4l8CazIsmYS
         q68cNWlrtygljbwguUd6ziQ6JYXi7obFzCTdUMHpys3b/InnI23OsRBWpsrzyJ8ENM/+
         xDbQ==
X-Gm-Message-State: AOJu0YwUhgRh8Amjanj3rEjtYIXUd3ZUyWFknbLWQ1XZB2xaohulRtWK
	ZUOTXHgXVAfullPrrx5IUSKY8pF4FZxeEkm6xu8=
X-Google-Smtp-Source: AGHT+IEwKu8EzQjvByj5NWZfr9xmqjwl1sVKCCUoaHA6EgIj0zsffvre60pqPYp9ur7SUNmiD8DmK8M78DpsMv7wkss=
X-Received: by 2002:a05:6512:546:b0:502:f2a4:152f with SMTP id
 h6-20020a056512054600b00502f2a4152fmr17222lfl.10.1694729274390; Thu, 14 Sep
 2023 15:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
 <20ef8441084c9d5fd54f84987afa77eed7fe148e.camel@gmail.com>
 <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
 <CAADnVQL0O_WFYcYQRig7osO0piPdOH2yHkdH0CxCfNV7NkA0Lw@mail.gmail.com>
 <035ab912d7d6bd11c54c038464795da01dbed2de.camel@gmail.com>
 <CAADnVQLMHUNE95eBXdy6=+gHoFHRsihmQ75GZvGy-hSuHoaT5A@mail.gmail.com>
 <5f8d82c3-838e-4d75-bb25-7d98a6d0a37c@sangfor.com.cn> <e564b0e9-3497-a133-3094-afefc0cd1f7e@oracle.com>
 <a0bd3ed9-afe7-49a4-a394-949bd5831d6d@sangfor.com.cn> <6b77425c-7f09-ae6d-c981-7cb2b3b826bd@oracle.com>
 <774732d7-1603-466e-8df2-3b21314913e5@sangfor.com.cn> <2d520a7b-9166-16c4-5385-5bb90437d45c@oracle.com>
In-Reply-To: <2d520a7b-9166-16c4-5385-5bb90437d45c@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Sep 2023 15:07:43 -0700
Message-ID: <CAADnVQLhn8bBBR6t5fNx-TmpH71_s=DgeoDXUKuSnU=oT+wwgg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Alan Maguire <alan.maguire@oracle.com>
Cc: pengdonglin <pengdonglin@sangfor.com.cn>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	dinghui@sangfor.com.cn, huangcun@sangfor.com.cn, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 10:14=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 14/09/2023 14:05, pengdonglin wrote:
> > On 2023/9/14 20:46, Alan Maguire wrote:
> >> On 14/09/2023 11:13, pengdonglin wrote:
> >>> On 2023/9/13 21:34, Alan Maguire wrote:
> >>>> On 13/09/2023 11:32, pengdonglin wrote:
> >>>>> On 2023/9/13 2:46, Alexei Starovoitov wrote:
> >>>>>> On Tue, Sep 12, 2023 at 10:03=E2=80=AFAM Eduard Zingerman <eddyz87=
@gmail.com>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> On Tue, 2023-09-12 at 09:40 -0700, Alexei Starovoitov wrote:
> >>>>>>>> On Tue, Sep 12, 2023 at 7:19=E2=80=AFAM Eduard Zingerman
> >>>>>>>> <eddyz87@gmail.com>
> >>>>>>>> wrote:
> >>>>>>>>>
> >>>>>>>>> On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
> >>>>>>>>>> On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
> >>>>>>>>>>> Currently, we are only using the linear search method to find
> >>>>>>>>>>> the
> >>>>>>>>>>> type id
> >>>>>>>>>>> by the name, which has a time complexity of O(n). This change
> >>>>>>>>>>> involves
> >>>>>>>>>>> sorting the names of btf types in ascending order and using
> >>>>>>>>>>> binary search,
> >>>>>>>>>>> which has a time complexity of O(log(n)). This idea was inspi=
red
> >>>>>>>>>>> by the
> >>>>>>>>>>> following patch:
> >>>>>>>>>>>
> >>>>>>>>>>> 60443c88f3a8 ("kallsyms: Improve the performance of
> >>>>>>>>>>> kallsyms_lookup_name()").
> >>>>>>>>>>>
> >>>>>>>>>>> At present, this improvement is only for searching in vmlinux=
's
> >>>>>>>>>>> and
> >>>>>>>>>>> module's BTFs, and the kind should only be BTF_KIND_FUNC or
> >>>>>>>>>>> BTF_KIND_STRUCT.
> >>>>>>>>>>>
> >>>>>>>>>>> Another change is the search direction, where we search the B=
TF
> >>>>>>>>>>> first and
> >>>>>>>>>>> then its base, the type id of the first matched btf_type will=
 be
> >>>>>>>>>>> returned.
> >>>>>>>>>>>
> >>>>>>>>>>> Here is a time-consuming result that finding all the type ids=
 of
> >>>>>>>>>>> 67,819 kernel
> >>>>>>>>>>> functions in vmlinux's BTF by their names:
> >>>>>>>>>>>
> >>>>>>>>>>> Before: 17000 ms
> >>>>>>>>>>> After:     10 ms
> >>>>>>>>>>>
> >>>>>>>>>>> The average lookup performance has improved about 1700x at th=
e
> >>>>>>>>>>> above scenario.
> >>>>>>>>>>>
> >>>>>>>>>>> However, this change will consume more memory, for example,
> >>>>>>>>>>> 67,819 kernel
> >>>>>>>>>>> functions will allocate about 530KB memory.
> >>>>>>>>>>
> >>>>>>>>>> Hi Donglin,
> >>>>>>>>>>
> >>>>>>>>>> I think this is a good improvement. However, I wonder, why did
> >>>>>>>>>> you
> >>>>>>>>>> choose to have a separate name map for each BTF kind?
> >>>>>>>>>>
> >>>>>>>>>> I did some analysis for my local testing kernel config and got
> >>>>>>>>>> such numbers:
> >>>>>>>>>> - total number of BTF objects: 97350
> >>>>>>>>>> - number of FUNC and STRUCT objects: 51597
> >>>>>>>>>> - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASE=
C
> >>>>>>>>>> objects: 56817
> >>>>>>>>>>      (these are all kinds for which lookup by name might make
> >>>>>>>>>> sense)
> >>>>>>>>>> - number of named objects: 54246
> >>>>>>>>>> - number of name collisions:
> >>>>>>>>>>      - unique names: 53985 counts
> >>>>>>>>>>      - 2 objects with the same name: 129 counts
> >>>>>>>>>>      - 3 objects with the same name: 3 counts
> >>>>>>>>>>
> >>>>>>>>>> So, it appears that having a single map for all named objects
> >>>>>>>>>> makes
> >>>>>>>>>> sense and would also simplify the implementation, what do you
> >>>>>>>>>> think?
> >>>>>>>>>
> >>>>>>>>> Some more numbers for my config:
> >>>>>>>>> - 13241 types (struct, union, typedef, enum), log2 13241 =3D 13=
.7
> >>>>>>>>> - 43575 funcs, log2 43575 =3D 15.4
> >>>>>>>>> Thus, having separate map for types vs functions might save ~1.=
7
> >>>>>>>>> search iterations. Is this a significant slowdown in practice?
> >>>>>>>>
> >>>>>>>> What do you propose to do in case of duplicates ?
> >>>>>>>> func and struct can have the same name, but they will have two
> >>>>>>>> different
> >>>>>>>> btf_ids. How do we store them ?
> >>>>>>>> Also we might add global vars to BTF. Such request came up sever=
al
> >>>>>>>> times.
> >>>>>>>> So we need to make sure our search approach scales to
> >>>>>>>> func, struct, vars. I don't recall whether we search any other
> >>>>>>>> kinds.
> >>>>>>>> Separate arrays for different kinds seems ok.
> >>>>>>>> It's a bit of code complexity, but it's not an increase in memor=
y.
> >>>>>>>
> >>>>>>> Binary search gives, say, lowest index of a thing with name A, th=
en
> >>>>>>> increment index while name remains A looking for correct kind.
> >>>>>>> Given the name conflicts info from above, 99% of times there
> >>>>>>> would be
> >>>>>>> no need to iterate and in very few cases there would a couple of
> >>>>>>> iterations.
> >>>>>>>
> >>>>>>> Same logic would be necessary with current approach if different =
BTF
> >>>>>>> kinds would be allowed in BTF_ID_NAME_* cohorts. I figured that
> >>>>>>> these
> >>>>>>> cohorts are mainly a way to split the tree for faster lookups, bu=
t
> >>>>>>> maybe that is not the main intent.
> >>>>>>>
> >>>>>>>> With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mby=
te
> >>>>>>>> extra memory. That's quite a bit. Anything we can do to compress
> >>>>>>>> it?
> >>>>>>>
> >>>>>>> That's an interesting question, from the top of my head:
> >>>>>>> pre-sort in pahole (re-assign IDs so that increasing ID also woul=
d
> >>>>>>> mean "increasing" name), shouldn't be that difficult.
> >>>>>>
> >>>>>> That sounds great. kallsyms are pre-sorted at build time.
> >>>>>> We should do the same with BTF.
> >>>>>> I think GCC can emit BTF directly now and LLVM emits it for bpf pr=
ogs
> >>>>>> too,
> >>>>>> but since vmlinux and kernel module BTFs will keep being processed
> >>>>>> through pahole we don't have to make gcc/llvm sort things right aw=
ay.
> >>>>>> pahole will be enough. The kernel might do 'is it sorted' check
> >>>>>> during BTF validation and then use binary search or fall back to
> >>>>>> linear
> >>>>>> when not-sorted =3D=3D old pahole.
> >>>>>>
> >>>>>
> >>>>> Yeah, I agree and will attempt to modify the pahole and perform a
> >>>>> test.
> >>>>> Do we need
> >>>>> to introduce a new macro to control the behavior when the BTF is no=
t
> >>>>> sorted? If
> >>>>> it is not sorted, we can use the method mentioned in this patch or =
use
> >>>>> linear
> >>>>> search.
> >>>>>
> >>>>>
> >>>>
> >>>> One challenge with pahole is that it often runs in parallel mode, so=
 I
> >>>> suspect any sorting would have to be done after merging across threa=
ds.
> >>>> Perhaps BTF deduplication time might be a useful time to re-sort by
> >>>> name? BTF dedup happens after BTF has been merged, and a new "sorted=
"
> >>>> btf_dedup_opts option could be added and controlled by a pahole
> >>>> option. However dedup is pretty complicated already..
> >>>>
> >>>> One thing we should weigh up though is if there are benefits to the
> >>>> way BTF is currently laid out. It tends to start with base types,
> >>>> and often-encountered types end up being located towards the start
> >>>> of the BTF data. For example
> >>>>
> >>>>
> >>>> [1] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64
> >>>> encoding=3D(none)
> >>>> [2] CONST '(anon)' type_id=3D1
> >>>> [3] VOLATILE '(anon)' type_id=3D1
> >>>> [4] ARRAY '(anon)' type_id=3D1 index_type_id=3D21 nr_elems=3D2
> >>>> [5] PTR '(anon)' type_id=3D8
> >>>> [6] CONST '(anon)' type_id=3D5
> >>>> [7] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSIGNE=
D
> >>>> [8] CONST '(anon)' type_id=3D7
> >>>> [9] INT 'unsigned int' size=3D4 bits_offset=3D0 nr_bits=3D32 encodin=
g=3D(none)
> >>>> [10] CONST '(anon)' type_id=3D9
> >>>> [11] TYPEDEF '__s8' type_id=3D12
> >>>> [12] INT 'signed char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=
=3DSIGNED
> >>>> [13] TYPEDEF '__u8' type_id=3D14
> >>>>
> >>>> So often-used types will be found quickly, even under linear search
> >>>> conditions.
> >>>
> >>> I found that there seems to be no code in the kernel that get the ID
> >>> of the
> >>> basic data type by calling btf_find_by_name_kind directly. The genera=
l
> >>> usage
> >>> of this function is to obtain the ID of a structure or function. Afte=
r
> >>> we got
> >>> the ID of a structure or function, it is O(1) to get the IDs of its
> >>> members
> >>> or parameters.
> >>>
> >>> ./kernel/trace/trace_probe.c:383:       id =3D btf_find_by_name_kind(=
btf,
> >>> funcname, BTF_KIND_FUNC);
> >>> ./kernel/bpf/btf.c:3523:        id =3D btf_find_by_name_kind(btf,
> >>> value_type, BTF_KIND_STRUCT);
> >>> ./kernel/bpf/btf.c:5504:                id =3D btf_find_by_name_kind(=
btf,
> >>> alloc_obj_fields[i], BTF_KIND_STRUCT);
> >>> ./kernel/bpf/bpf_struct_ops.c:128:      module_id =3D
> >>> btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
> >>> ./net/ipv4/bpf_tcp_ca.c:28:     type_id =3D btf_find_by_name_kind(btf=
,
> >>> "sock", BTF_KIND_STRUCT);
> >>> ./net/ipv4/bpf_tcp_ca.c:33:     type_id =3D btf_find_by_name_kind(btf=
,
> >>> "tcp_sock", BTF_KIND_STRUCT);
> >>> ./net/netfilter/nf_bpf_link.c:181:      type_id =3D
> >>> btf_find_by_name_kind(btf, name, BTF_KIND_STRUCT);
> >>>
> >>>>
> >>>> When we look at how many lookups by id (which are O(1), since they a=
re
> >>>> done via the btf->types[] array) versus by name, we see:
> >>>>
> >>>> $ grep btf_type_by_id kernel/bpf/*.c|wc -l
> >>>> 120
> >>>> $ grep btf_find_by_nam kernel/bpf/*.c|wc -l
> >>>> 15
> >>>>
> >>>> I don't see a huge number of name-based lookups, and I think most ar=
e
> >>>> outside of the hotter codepaths, unless I'm missing some. All of whi=
ch
> >>>> is to say it would be a good idea to have a clear sense of what will
> >>>> get
> >>>> faster with sorted-by-name BTF. Thanks!
> >>>
> >>> The story goes like this.
> >>>
> >>> I have added a new feature to the function graph called
> >>> "funcgraph_retval",
> >>> here is the link:
> >>>
> >>> https://lore.kernel.org/all/1fc502712c981e0e6742185ba242992170ac9da8.=
1680954589.git.pengdonglin@sangfor.com.cn/
> >>>
> >>> We can obtain the return values of almost every function during the
> >>> execution
> >>> of kernel through this feature, it can help us analyze problems.
> >>>
> >>
> >> It's a great feature!
> >
> > Thanks.
> >
> >>
> >>> However, this feature has two main drawbacks.
> >>>
> >>> 1. Even if a function's return type is void,  a return value will sti=
ll
> >>> be printed.
> >>>
> >>> 2. The return value printed may be incorrect when the width of the
> >>> return type is
> >>> smaller than the generic register.
> >>>
> >>> I think if we can get this return type of the function, then the
> >>> drawbacks mentioned
> >>> above can be eliminated. The function btf_find_by_name_kind can be us=
ed
> >>> to get the ID of
> >>> the kernel function, then we can get its return type easily. If the
> >>> return type is
> >>> void, the return value recorded will not be printed. If the width of =
the
> >>> return type
> >>> is smaller than the generic register, then the value stored in the up=
per
> >>> bits will be
> >>> trimmed. I have written a demo and these drawbacks were resolved.
> >>>
> >>> However, during my test, I found that it took too much time when read
> >>> the trace log
> >>> with this feature enabled, because the trace log consists of 200,000
> >>> lines. The
> >>> majority of the time was consumed by the btf_find_by_name_kind, which=
 is
> >>> called
> >>> 200,000 times.
> >>>
> >>> So I think the performance of btf_find_by_name_kind  may need to be
> >>> improved.
> >>>
> >>
> >> If I recall, Masami's work uses BTF ids, but can cache them since the
> >> user explicitly asks for specific fields in the trace output. I'm
> >> presuming that's not an option for you due to the fact funcgraph traci=
ng
> >> enables everything (or at least everything under a filter predicate) a=
nd
> >> you have limited context to work with, is that right?
> >
> > Yes, right.
> >
> >>
> >> Looking at print_graph_entry_leaf() which I _think_ is where you'd nee=
d
> >> to print the retval from, you have access to the function address via
> >> call->func, and I presume you get the name from snprinting the symbol =
to
> >> a string or similar. So you're stuck in a context where you have the
> >> function address, and from that you can derive the function name. Is
> >> that correct? Thanks!
> >
> > Yes, both print_graph_return and print_graph_entry_leaf will call
> > print_graph_retval
> > to print the return value. Then call sprint_symbol_no_offset with
> > call->func to get
> > the function name, then call btf_find_by_name_kind to get the return ty=
pe.
> >
>
> So what you ultimately need is a way to map from that information
> available to be able to figure out the size of the return value
> associated with a function.
>
> On the BPF side we've been thinking a bit about the relationship between
> kernel function addresses and their BTF representations; sometimes
> knowing BTF->address mapping is needed for cases where the same function
> name has multiple inconsistent function signatures in BTF. We don't
> represent function addresses yet in BTF but may end up having to.
> The reason I mention this is in an ideal world, it would benefit to
> populate kallsyms entries with their associated BTF ids;

I think it would be cleaner to keep addresses in BTF.
Since we might have same btf_id func with multiple addresses
and same name, but different btf_id with multi address too.
I suspect one to one kallsym to btf_id won't cover all cases.

Also we search BTFs not only for vars/funcs, but for types too.
It's better to optimize btf_find_by_name_kind() that it's fast
for finding structs by name too.

imo Eduard's proposal to sort all BTFs by name after dedup is the best.
I don't think sorting will add a noticeable build time increase.
We don't need to add pahole flags either.
The kernel can handle sorted vs non-sorted BTFs transparently.

