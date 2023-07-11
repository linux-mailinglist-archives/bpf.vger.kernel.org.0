Return-Path: <bpf+bounces-4751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09274EBE7
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 12:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2378C1C20D55
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 10:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8238F174EB;
	Tue, 11 Jul 2023 10:45:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4824410
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 10:45:03 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38074E60;
	Tue, 11 Jul 2023 03:44:59 -0700 (PDT)
X-UUID: 5ab2eed8384245e190523efe0c7c4026-20230711
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:232bb03d-c028-437f-8d8f-aa2a3e0548cf,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:6
X-CID-INFO: VERSION:1.1.27,REQID:232bb03d-c028-437f-8d8f-aa2a3e0548cf,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:6
X-CID-META: VersionHash:01c9525,CLOUDID:aef8deda-b4fa-43c8-9c3e-0d3fabd03ec0,B
	ulkID:230711184442Q5F2LS16,BulkQuantity:0,Recheck:0,SF:24|17|19|42|38|102,
	TC:nil,Content:1,EDM:-3,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 5ab2eed8384245e190523efe0c7c4026-20230711
X-User: jianghaoran@kylinos.cn
Received: from [172.30.60.211] [(39.156.73.12)] by mailgw
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1961543371; Tue, 11 Jul 2023 18:44:40 +0800
Message-ID: <b470ee4c7681eb37c45bb2ff38342281f89bb1ae.camel@kylinos.cn>
Subject: =?gb2312?Q?=BB=D8=B8=B4=A3=BA=5BPATCH?= v2] samples/bpf: Fix
 compilation failure for samples/bpf on LoongArch Fedora
From: "jianghaoran@kylinos.cn" <jianghaoran@kylinos.cn>
To: Daniel Borkmann <daniel@iogearbox.net>, Huacai Chen
 <chenhuacai@kernel.org>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 haoluo@google.com,  john.fastabend@gmail.com, jolsa@kernel.org,
 kernel@xen0n.name, kpsingh@kernel.org,  linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, loongarch@lists.linux.dev,  martin.lau@linux.dev,
 nathan@kernel.org, ndesaulniers@google.com, sdf@google.com, 
 song@kernel.org, trix@redhat.com, yangtiezhu@loongson.cn, yhs@fb.com
Date: Tue, 11 Jul 2023 18:39:03 +0800
In-Reply-To: <7ecc42aa-4a0f-77f7-a2ad-236270137b6e@iogearbox.net>
References: 
	<CAAhV-H6s3N=-brDz24PfrtEKNFjvnLjbDR2NpOVDF_fN7rA53A@mail.gmail.com>
	 <20230710052750.259595-1-jianghaoran@kylinos.cn>
	 <CAAhV-H7orsUHDZuwcTUeWYbizcWRG4k_BPy53W7PT_MQ_2SXgw@mail.gmail.com>
	 <7ecc42aa-4a0f-77f7-a2ad-236270137b6e@iogearbox.net>
Content-Type: text/plain; charset="euc-tw"
User-Agent: Evolution 3.36.1-2kord0k2.3.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

=C7=E3 2023-07-11=D1=D3=DF=E6=C4=A8=CE=FB 09:39 +0200=A1=A2Daniel Borkmann=
=8E=A3=A1=FA=E7=AC=A1=A8
> On 7/10/23 7:54 AM, Huacai Chen wrote:
> > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> >=20
> > On Mon, Jul 10, 2023 at 1:34PM Haoran Jiang <
> > jianghaoran@kylinos.cn> wrote:
> > > When building the latest samples/bpf on LoongArch Fedora
> > >=20
> > >       make M=3Dsamples/bpf
> > >=20
> > > There are compilation errors as follows:
> > >=20
> > > In file included from ./linux/samples/bpf/sockex2_kern.c:2:
> > > In file included from ./include/uapi/linux/in.h:25:
> > > In file included from ./include/linux/socket.h:8:
> > > In file included from ./include/linux/uio.h:9:
> > > In file included from ./include/linux/thread_info.h:60:
> > > In file included from
> > > ./arch/loongarch/include/asm/thread_info.h:15:
> > > In file included from
> > > ./arch/loongarch/include/asm/processor.h:13:
> > > In file included from ./arch/loongarch/include/asm/cpu-info.h:11:
> > > ./arch/loongarch/include/asm/loongarch.h:13:10: fatal error:
> > > 'larchintrin.h' file not found
> > >           ^~~~~~~~~~~~~~~
> > > 1 error generated.
> > >=20
> > > larchintrin.h is included in /usr/lib64/clang/14.0.6/include,
> > > and the header file location is specified at compile time.
> > >=20
> > > Test on LoongArch Fedora:
> > > https://github.com/fedora-remix-loongarch/releases-info
> > >=20
> > > Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> > >=20
> > > ---
> > > v2:
> > > use LoongArch instead of Loongarch in the title and commit
> > > message.
> > > ---
> > >   samples/bpf/Makefile | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > > index 615f24ebc49c..b301796a3862 100644
> > > --- a/samples/bpf/Makefile
> > > +++ b/samples/bpf/Makefile
> > > @@ -434,7 +434,7 @@ $(obj)/%.o: $(src)/%.c
> > >          @echo "  CLANG-bpf " $@
> > >          $(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)
> > > $(BPF_EXTRA_CFLAGS) \
> > >                  -I$(obj)
> > > -I$(srctree)/tools/testing/selftests/bpf/ \
> > > -               -I$(LIBBPF_INCLUDE) \
> > > +               -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>=20
> There's still one location in XDP_SAMPLE_CFLAGS, do we need the
> $(CLANG_SYS_INCLUDES)
> there as well?

XDP_SAMPLE_CFLAGS only affects the compilation of xdp_sample_user.c. It
is a user-mode application=A1=A2the associated header files of clang are no=
t
used. larchintrin.h will only be included in *.bpf.c and *kern.c
files.So I don't think $(CLANG_SYS_INCLUDES) needs to be included here.

>=20
> > >                  -D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value=20
> > > -Wno-pointer-sign \
> > >                  -D__TARGET_ARCH_$(SRCARCH) -Wno-compare-
> > > distinct-pointer-types \
> > >                  -Wno-gnu-variable-sized-type-not-at-end \
> > > --
> > > 2.27.0
> > >=20
> > >=20


