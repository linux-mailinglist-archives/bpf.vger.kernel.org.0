Return-Path: <bpf+bounces-79451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8408D3A9D8
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8765D303D341
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C070D36405A;
	Mon, 19 Jan 2026 13:01:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D6363C7F
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827705; cv=none; b=KyRgUmzxPzYYvtAKAl8VAiCmNTbRMW/KzWLxDNRQnGbp5rCN1xQQdXxoz7r47vakPV6dO8v7LV35RNdVPq0WZwkzueP2N77jU4K+kgAqZndHPvwmpjrw2VmM3O3tCrkLAyIrEHCKJyH3QcgwwPwwZPD01S2K5Uec7uMzVqGDzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827705; c=relaxed/simple;
	bh=0bIqaq8qvfyPVtqblw/rWkEa3RnV3OOcHHkwRqyrr7M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ShwncdN4YM9NQrIbmz6ZnB4ApjPsjoLxeVAYtZIaYTTN1p2EZ981MbNBMezsDb3kgFpi+QPoJIiiTXypEaPqXI6SSD9gwyuU7gqDaQm0141s5mQBGHX/iAKWCt4/ZJYONtwrQ5Ricx40N3Wzm9CDUUALekiFdwptdVmn9kKmTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxecIxK25pbFMKAA--.33369S3;
	Mon, 19 Jan 2026 21:01:37 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxHMIrK25p4HUlAA--.8265S3;
	Mon, 19 Jan 2026 21:01:32 +0800 (CST)
Subject: Re: [BUG?]: bpf/selftests: ns_bpf_qdisc libbpf: loading object
 'tc_bpf' from buffer
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, loongarch@lists.linux.dev, ast
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Hengqi Chen <hengqi.chen@gmail.com>, Chenghao Duan
 <duanchenghao@kylinos.cn>, Huacai Chen <chenhuacai@kernel.org>
References: <CAK3+h2yu+XkEMWz6FOHiDEEQw-G_iKG2KHP=F=1CiqLr0mCgNA@mail.gmail.com>
 <d299d7ba-4e9e-5b16-5aa4-898b62330c24@loongson.cn>
 <CAK3+h2yFJDNVPo=38PcYCMNhmw0cQBouL5h7sX0KmyLu-_5zwQ@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <c15fd22f-9c36-bf8d-5bd4-02993147d113@loongson.cn>
Date: Mon, 19 Jan 2026 21:01:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK3+h2yFJDNVPo=38PcYCMNhmw0cQBouL5h7sX0KmyLu-_5zwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMIrK25p4HUlAA--.8265S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr45Ar4UJr1rZw17Gw1kXrc_yoW8CrWrpa
	yrtF18KryvqF1rurWkGrW8KrW3G3ZrA3yrKrW7Kw4rGasxuryakr95J3W2qrnFqa4vkw42
	9rZ5GF4Skw47AabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcApnDU
	UUU

On 2026/1/16 上午4:44, Vincent Li wrote:
> On Wed, Jan 14, 2026 at 5:13 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

...

> Do you have proper instructions to compile gcc?

git clone git://gcc.gnu.org/git/gcc.git gcc
cd gcc && ./contrib/download_prerequisites --no-verify
cp config.guess gettext/build-aux/config.guess && cp config.sub 
gettext/build-aux/config.sub
cp config.guess gmp/config.guess && cp config.sub gmp/config.sub
cp config.guess mpfr/config.guess && cp config.sub mpfr/config.sub
cp config.guess mpc/build-aux/config.guess && cp config.sub 
mpc/build-aux/config.sub
cp config.guess isl/config.guess && cp config.sub isl/config.sub
rm -rf build && mkdir -p build && cd build
../configure --prefix=/usr/local/gcc --enable-checking=release 
--enable-languages=c,c++ --disable-multilib
make -j"$(nproc)"
sudo rm -rf /usr/local/gcc && sudo make install
export PATH=/usr/local/gcc/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/gcc/lib:$LD_LIBRARY_PATH

> I am not sure if it is toolchain related. The thing that really
> bothered me is why the hell tc_bpf is loaded by libbpf for
> ns_bpf_qdisc selftests that seems to have nothing to do with the
> tc_bpf object, I can't think of anything special in my build machine
> that would trigger this. Anyway, thanks for the help!

I tested it again with lower version tool chains, the test still passed
on my environment.

fedora@linux:~$ clang --version | head -1
clang version 19.1.6 (Fedora 19.1.6-3.fc42)
fedora@linux:~$ gcc --version | head -1
gcc (GCC) 14.2.1 20241104 (Red Hat 14.2.1-6)
fedora@linux:~$ as --version | head -1
GNU assembler version 2.43.50.20241126
fedora@linux:~$ pahole --version
v1.31
fedora@linux:~$ uname -r
6.19.0-rc6
fedora@linux:~$ uname -m
loongarch64

Thanks,
Tiezhu


