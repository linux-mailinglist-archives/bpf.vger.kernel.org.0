Return-Path: <bpf+bounces-10965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32367B0559
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 860431C20A35
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC2731A88;
	Wed, 27 Sep 2023 13:27:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BC286BD
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 13:27:26 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91ACF5
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 06:27:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5346b64f17aso4373771a12.2
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695821242; x=1696426042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qtdeMiCSUA42XqdTGIn8qU1ZmDRSv+rgZ+x8Os0VGew=;
        b=W/Tr+CxZGOaVG8BaZLOQJVaOk0jt3BeuvCBcNfc0V3pHUt0uPp4/DoizV3ylZmXEGN
         em4W59MvzfljQ3Phw1Z3aX8w9yOCwMPsZD6ME2d2H6Vqspd2PQsWIHE95/+rE+5VA7uD
         5q1HeeXHMdT2odpDNa8HwtX50EmAXPJP0taaMup1HP0wwhrDclfAujBYKE4vQpEI4v/w
         KemAa2D4hEcfUZ+tSkUOxtB1tusFXHu7G4w4eIJ0fzaXckTiBN8by3eZqpdTTAbczqjN
         p1IHVrLKyok8qgCtG7oUILz4Pt8WPlFKw9gDPRBqKoMVNplxEnTvceKIaUTRLfWRSZOS
         Aj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695821242; x=1696426042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtdeMiCSUA42XqdTGIn8qU1ZmDRSv+rgZ+x8Os0VGew=;
        b=wcRcMiKxl50MloHK/egKLns0NCdsyYDbxB3tOFdmtTXanuVxlAp+ahl2nij8TQ5WNs
         QnvaMDN2kDDktFsBcZlkFjd1BIuL0azgV68Op6yFZnUP8FUcWj5R8KOv4aPhlmdgDd+V
         RylvtA+RICQElyG18XUtsIjJipFG26A3ZyIiYU2Jg8ZwJ3YAhGI23a7UKJWupbpf0GSJ
         lSr10rf0pPZ1gmZl2JjG7RzsJN1pBcV9J8Ddf65fMojs8BJFwWeXAE1g/mEZJrKiFr1S
         2+qCMBts1SiRab557HVgX+EibVyGqJKgDIITAwmEDSpBX1Qb4DMT3d3VzIfg/yZXAoSf
         XKRg==
X-Gm-Message-State: AOJu0Yw4thET7ZJt2aZ1Oma9QG7TrIB8goToqFkxuCpJwMKjIx61AK2G
	o4qKN+1nWFwEq8pI3cwM89IEyQ==
X-Google-Smtp-Source: AGHT+IEG9HJ17DjMHwori0MJKhy5I50vAo2y+Pi/y0x/Y8Hfru1ANcSNgd9yVs29n4kp9nS6nQzGlQ==
X-Received: by 2002:a17:907:1c8e:b0:9ae:76b4:c039 with SMTP id nb14-20020a1709071c8e00b009ae76b4c039mr2103456ejc.31.1695821242055;
        Wed, 27 Sep 2023 06:27:22 -0700 (PDT)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id gs10-20020a170906f18a00b009ae40563b7csm9278778ejb.21.2023.09.27.06.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:27:21 -0700 (PDT)
Date: Wed, 27 Sep 2023 13:27:15 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>, Marek Majkowski <marek@cloudflare.com>,
	Lorenz Bauer <lmb@cloudflare.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: bpf indirect calls
Message-ID: <ZRQtsyYM810Oh4px@google.com>
References: <157046883614.2092443.9861796174814370924.stgit@alrua-x1>
 <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com>
 <87sgo3lkx9.fsf@toke.dk>
 <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com>
 <87o8yqjqg0.fsf@toke.dk>
 <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com>
 <87v9srijxa.fsf@toke.dk>
 <20191016022849.weomgfdtep4aojpm@ast-mbp>
 <8736fshk7b.fsf@toke.dk>
 <20191019200939.kiwuaj7c4bg25vqs@ast-mbp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191019200939.kiwuaj7c4bg25vqs@ast-mbp>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 19, 2019 at 01:09:42PM -0700, Alexei Starovoitov wrote:
> On Wed, Oct 16, 2019 at 03:51:52PM +0200, Toke Høiland-Jørgensen wrote:
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> > 
> > > On Mon, Oct 14, 2019 at 02:35:45PM +0200, Toke Høiland-Jørgensen wrote:
> > >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> > >> 
> > >> > On Wed, Oct 09, 2019 at 10:03:43AM +0200, Toke Høiland-Jørgensen wrote:
> > >> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> > >> >> 
> > >> >> > Please implement proper indirect calls and jumps.
> > >> >> 
> > >> >> I am still not convinced this will actually solve our problem; but OK, I
> > >> >> can give it a shot.
> > >> >
> > >> > If you're not convinced let's talk about it first.
> > >> >
> > >> > Indirect calls is a building block for debugpoints.
> > >> > Let's not call them tracepoints, because Linus banned any discusion
> > >> > that includes that name.
> > >> > The debugpoints is a way for BPF program to insert points in its
> > >> > code to let external facility to do tracing and debugging.
> > >> >
> > >> > void (*debugpoint1)(struct xdp_buff *, int code);
> > >> > void (*debugpoint2)(struct xdp_buff *);
> > >> > void (*debugpoint3)(int len);
> > >> 
> > >> So how would these work? Similar to global variables (i.e., the loader
> > >> creates a single-entry PROG_ARRAY map for each one)? Presumably with
> > >> some BTF to validate the argument types?
> > >> 
> > >> So what would it take to actually support this? It doesn't quite sound
> > >> trivial to add?
> > >
> > > Depends on definition of 'trivial' :)
> > 
> > Well, I don't know... :)
> > 
> > > The kernel has a luxury of waiting until clean solution is implemented
> > > instead of resorting to hacks.
> > 
> > It would be helpful if you could give an opinion on what specific
> > features are missing in the kernel to support these indirect calls. A
> > few high-level sentences is fine (e.g., "the verifier needs to be able
> > to do X, and llvm/libbpf needs to have support for Y")... I'm trying to
> > gauge whether this is something it would even make sense for me to poke
> > into, or if I'm better off waiting for someone who actually knows what
> > they are doing to work on this :)
> 
> I have to reveal a secret first...
> llvm supports indirect calls since 2017 ;)
> 
> It can compile the following:
> struct trace_kfree_skb {
> 	struct sk_buff *skb;
> 	void *location;
> };
> 
> typedef void (*fn)(struct sk_buff *skb);
> static fn func;
> 
> SEC("tp_btf/kfree_skb")
> int trace_kfree_skb(struct trace_kfree_skb *ctx)
> {
> 	struct sk_buff *skb = ctx->skb;
> 	fn f = *(volatile fn *)&func;
> 
> 	if (f)
> 		f(skb);
> 	return 0;
> }
> 
> into proper BPF assembly:
> ; 	struct sk_buff *skb = ctx->skb;
>        0:	79 11 00 00 00 00 00 00	r1 = *(u64 *)(r1 + 0)
> ; 	fn f = *(volatile fn *)&func;
>        1:	18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00	r2 = 0 ll
>        3:	79 22 00 00 00 00 00 00	r2 = *(u64 *)(r2 + 0)
> ; 	if (f)
>        4:	15 02 01 00 00 00 00 00	if r2 == 0 goto +1 <LBB0_2>
> ; 		f(skb);
>        5:	8d 00 00 00 02 00 00 00	callx 2
> 0000000000000030 LBB0_2:
> ; 	return 0;
>        6:	b7 00 00 00 00 00 00 00	r0 = 0
>        7:	95 00 00 00 00 00 00 00	exit
> 
> Indirect call is encoded as JMP|CALL|X
> Normal call is JMP|CALL|K
> 
> What's left to do is to teach the verifier to parse BTF of global data.
> Then teach it to recognize that r2 at insn 1 is PTR_TO_BTF_ID
> where btf_id is DATASEC '.bss'
> Then load r2+0 is also PTR_TO_BTF_ID where btf_id is VAR 'func'.
> New bool flag to reg_state is needed to tell whether if(rX==NULL) check
> was completed.
> Then at insn 5 the verifier will see that R2 is PTR_TO_BTF_ID and !NULL
> and it's a pointer to a function.
> Depending on function prototype the verifier would need to check that
> R1's type match to arg1 of func proto.
> For simplicity we don't need to deal with pointers to stack,
> pointers to map, etc. Only PTR_TO_BTF_ID where btf_id is a kernel
> data structure or scalar is enough to get a lot of mileage out of
> this indirect call feature.
> That's mostly it.
> 
> Few other safety checks would be needed to make sure that writes
> into 'r2+0' are also of correct type.
> We also need partial map_update bpf_sys command to populate
> function pointer with another bpf program that has matching
> function proto.
> 
> I think it's not trivial verifier work, but not hard either.
> I'm happy to do it as soon as I find time to work on it.

Alexei,

Sorry to resurrect this incredibly old thread, but I was wondering
whether BPF indirect calls are supported in the latest kernel
versions?

I was performing some experiments within a BPF program today which
leveraged indirect calls, but I was continuously running into BPF
verifier errors, specifically errors related to an "unknown opcode 8d"
being used within the BPF program. It turns out that the encoded
opcode "8d" decodes to "BPF_JMP | BPF_CALL | BPF_X", which apparently
is forbidden based on the bpf_opcode_in_insntable() check, but given
this thread I wasn't exactly sure what the status was on indirect
calls support?

Note that the example BPF program that I was attempting to load on a
6.4 kernel was as follows:
```
struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, u32);
  __type(value, u64);
  __uint(max_entries, 32);
} map SEC(".maps");

static void testing(void) {
  bpf_printk("testing");
}

struct iter_ctx {
  void (*f) (void);
};
static u64 iter_callback(struct bpf_map *map, u32 *key,
                         u64 *value, struct iter_ctx *ctx) {
  if (ctx->f) {
    ctx->f();
  }
  return 0;
}

SEC("lsm.s/file_open")
int BPF_PROG(file_open, struct file *file)
{
  struct iter_ctx iter_ctx = {
    .f = testing,
  };
  bpf_for_each_map_elem(&map, iter_callback, &iter_ctx, 0);
  return 0;
}
```

This BPF program produced the following disassembly:
```
0000000000000000 <testing>:
       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
       2:       b7 02 00 00 08 00 00 00 r2 = 0x8
       3:       85 00 00 00 06 00 00 00 call 0x6
       4:       95 00 00 00 00 00 00 00 exit

0000000000000028 <iter_callback>:
       5:       79 41 00 00 00 00 00 00 r1 = *(u64 *)(r4 + 0x0)
       6:       15 01 01 00 00 00 00 00 if r1 == 0x0 goto +0x1 <LBB2_2>
       7:       8d 00 00 00 01 00 00 00 callx r1

0000000000000040 <LBB2_2>:
       8:       b7 00 00 00 00 00 00 00 r0 = 0x0
       9:       95 00 00 00 00 00 00 00 exit

Disassembly of section lsm.s/file_open:

0000000000000000 <file_open>:
       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
       2:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) = r1
       3:       bf a3 00 00 00 00 00 00 r3 = r10
       4:       07 03 00 00 f8 ff ff ff r3 += -0x8
       5:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
       7:       18 02 00 00 28 00 00 00 00 00 00 00 00 00 00 00 r2 = 0x28 ll
       9:       b7 04 00 00 00 00 00 00 r4 = 0x0
      10:       85 00 00 00 a4 00 00 00 call 0xa4
      11:       b7 00 00 00 00 00 00 00 r0 = 0x0
      12:       95 00 00 00 00 00 00 00 exit
```

What's interesting though is that with a somewhat similar BPF program
which made use of indirect calls, the BPF verifier generated no errors:

```
static __attribute__((noinline)) void testing(void) {
  bpf_printk("testing");
}

SEC("lsm.s/file_open")
int BPF_PROG(file_open, struct file *file)
{
  void (*f) (void) = testing;
  f();
  return 0;
}
```

This BPF program produced the following disassembly:
```
0000000000000000 <testing>:
       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
       2:       b7 02 00 00 08 00 00 00 r2 = 0x8
       3:       85 00 00 00 06 00 00 00 call 0x6
       4:       95 00 00 00 00 00 00 00 exit

Disassembly of section lsm.s/file_open:

0000000000000000 <file_open>:
       0:       85 10 00 00 ff ff ff ff call -0x1
       1:       b7 00 00 00 00 00 00 00 r0 = 0x0
       2:       95 00 00 00 00 00 00 00 exit
```

The fundamental difference between the two call instructions if I'm
not mistaken is that one attempts to perform a call using an immediate
value as its source operand, whereas the other attempts to perform a
call using a source register as its source operand. AFAIU, the latter
is not currently permitted by the BPF verifier. Is that right?

/M

