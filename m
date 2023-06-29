Return-Path: <bpf+bounces-3689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D527741F42
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40951C2048D
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 04:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1576E3FDB;
	Thu, 29 Jun 2023 04:31:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ACC5223;
	Thu, 29 Jun 2023 04:31:20 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568311FD8;
	Wed, 28 Jun 2023 21:31:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qs59s48xxz4f3rhk;
	Thu, 29 Jun 2023 12:31:13 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCX8BoOCZ1kJmxZMA--.23088S2;
	Thu, 29 Jun 2023 12:31:14 +0800 (CST)
Subject: Re: [PATCH v3 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-13-alexei.starovoitov@gmail.com>
 <57ceda87-e882-54b0-057a-2767c4395122@huaweicloud.com>
 <CAADnVQ+V_SiZynZfGMWjSqkKb+8xggvBUmy7oTFUcvGq_2CcLg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <df46e0cc-cf0f-76a1-60a0-ef1ef8b8280a@huaweicloud.com>
Date: Thu, 29 Jun 2023 12:31:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+V_SiZynZfGMWjSqkKb+8xggvBUmy7oTFUcvGq_2CcLg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------C6B3E9B949ACD7FCEA0E01C3"
Content-Language: en-US
X-CM-TRANSID:cCh0CgCX8BoOCZ1kJmxZMA--.23088S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4xJF17JFyfCrWkWF1DAwb_yoWrAFWDpF
	1xtF17Jry8Jr4rtryUtr4UJ34UJr4jqw1UJ34UJFnIkr1UXr1YqF17ur1jgFn8Jr48C343
	Jr1DWry7Zr1UZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21le4C267I2x7xF54xIwI1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxV
	WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFcxC0VAYjxAxZF0Ex2Iq
	xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJwCE64xvF2IEb7IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x07UZF4iU
	UUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multi-part message in MIME format.
--------------C6B3E9B949ACD7FCEA0E01C3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/29/2023 11:42 AM, Alexei Starovoitov wrote:
> On Wed, Jun 28, 2023 at 7:24 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 6/28/2023 9:56 AM, Alexei Starovoitov wrote:
>>> From: Alexei Starovoitov <ast@kernel.org>
>>>
>>> Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
>>> Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
>>> per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
>>> objects into free_by_rcu_ttrace list where they are waiting for RCU
>>> task trace grace period to be freed into slab.
>>>
>>> The life cycle of objects:
>>> alloc: dequeue free_llist
>>> free: enqeueu free_llist
>>> free_rcu: enqueue free_by_rcu -> waiting_for_gp
>>> free_llist above high watermark -> free_by_rcu_ttrace
>>> after RCU GP waiting_for_gp -> free_by_rcu_ttrace
>>> free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab
>>>
>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> SNIP
>>> +static void __free_by_rcu(struct rcu_head *head)
>>> +{
>>> +     struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
>>> +     struct bpf_mem_cache *tgt = c->tgt;
>>> +     struct llist_node *llnode;
>>> +
>>> +     llnode = llist_del_all(&c->waiting_for_gp);
>>> +     if (!llnode)
>>> +             goto out;
>>> +
>>> +     llist_add_batch(llnode, c->waiting_for_gp_tail, &tgt->free_by_rcu_ttrace);
>>> +
>>> +     /* Objects went through regular RCU GP. Send them to RCU tasks trace */
>>> +     do_call_rcu_ttrace(tgt);
>> I still got report about leaked free_by_rcu_ttrace without adding any
>> extra hack except using bpf_mem_cache_free_rcu() in htab.
> Please share the steps to repro.
Firstly, I added the attached patch to check whether or not there are
leaked elements when calling free_mem_alloc_no_barrier(), then I ran the
following scripts to do the stress test in a kvm VM with 72 CPUs and
64GB memory:


#!/bin/bash

BASE=/all/code/linux_working/

{
        cd $BASE/tools/testing/selftests/bpf
        for x in $(seq 2)
        do
                while true; do ./test_maps &>/dev/null; done &
        done
} &

{
        cd $BASE/samples/bpf
        for y in $(seq 8)
        do
                while true; do ./map_perf_test &>/dev/null; done &
        done
} &

{
        cd $BASE/tools/testing/selftests/bpf
        for z in $(seq 8)
        do
                while true
                do
                        for name in overwrite batch_add_batch_del
add_del_on_diff_cpu
                        do
                                ./bench htab-mem -w1 -d5 -a -p32
--use-case $name
                        done
                done &>/dev/null &
                sleep 0.3
        done
} &


>
>> When bpf ma is freed through free_mem_alloc(), the following sequence
>> may lead to leak of free_by_rcu_ttrace:
>>
>> P1: bpf_mem_alloc_destroy()
>>     P2: __free_by_rcu()
>>
>>     // got false
>>     P2: read c->draining
>>
>> P1: c->draining = true
>> P1: llist_del_all(&c->free_by_rcu_ttrace)
>>
>>     // add to free_by_rcu_ttrace again
>>     P2: llist_add_batch(..., &tgt->free_by_rcu_ttrace)
>>         P2: do_call_rcu_ttrace()
>>             // call_rcu_ttrace_in_progress is 1, so xchg return 1
>>             // and it doesn't being moved to waiting_for_gp_ttrace
>>             P2: atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)
>>
>> // got 1
>> P1: atomic_read(&c->call_rcu_ttrace_in_progress)
>> // objects in free_by_rcu_ttrace is leaked
>>
>> I think the race could be fixed by checking c->draining in
>> do_call_rcu_ttrace() when atomic_xchg() returns 1 as shown below:
> If the theory of the bug holds true then the fix makes sense,
> but did you repro without fix and cannot repro with the fix?
> We should not add extra code based on a hunch.
Yes. With the fix applied only, the leak didn't occur in the last 13 hours.
>
> .


--------------C6B3E9B949ACD7FCEA0E01C3
Content-Type: text/plain; charset=UTF-8;
 name="0001-bpf-Check-leaked-objects.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-bpf-Check-leaked-objects.patch"

RnJvbSA1ZTQ0ZWMyOWY1YWEwMzdiYThkMTE4OGNjZWU0NTZhYjM5OTZkMDNlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIb3UgVGFvIDxob3V0YW8xQGh1YXdlaS5jb20+CkRh
dGU6IFdlZCwgMjEgSnVuIDIwMjMgMTc6MTc6NTIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBi
cGY6IENoZWNrIGxlYWtlZCBvYmplY3RzCgotLS0KIGtlcm5lbC9icGYvbWVtYWxsb2MuYyB8
IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0KIDEgZmls
ZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2tlcm5lbC9icGYvbWVtYWxsb2MuYyBiL2tlcm5lbC9icGYvbWVtYWxsb2MuYwppbmRl
eCAzMDgxZDA2YTQzNGMuLjJiZGI4OTQzOTJjNSAxMDA2NDQKLS0tIGEva2VybmVsL2JwZi9t
ZW1hbGxvYy5jCisrKyBiL2tlcm5lbC9icGYvbWVtYWxsb2MuYwpAQCAtNTY1LDggKzU2NSw1
MCBAQCBzdGF0aWMgdm9pZCBkcmFpbl9tZW1fY2FjaGUoc3RydWN0IGJwZl9tZW1fY2FjaGUg
KmMpCiAJZnJlZV9hbGwobGxpc3RfZGVsX2FsbCgmYy0+d2FpdGluZ19mb3JfZ3ApLCBwZXJj
cHUpOwogfQogCi1zdGF0aWMgdm9pZCBmcmVlX21lbV9hbGxvY19ub19iYXJyaWVyKHN0cnVj
dCBicGZfbWVtX2FsbG9jICptYSkKK3N0YXRpYyB2b2lkIGNoZWNrX21lbV9jYWNoZShzdHJ1
Y3QgYnBmX21lbV9jYWNoZSAqYywgYm9vbCBkaXJlY3QpCit7CisJaWYgKCFsbGlzdF9lbXB0
eSgmYy0+ZnJlZV9ieV9yY3VfdHRyYWNlKSkKKwkJcHJfd2FybigibGVhazogZnJlZV9ieV9y
Y3VfdHRyYWNlICVkXG4iLCBkaXJlY3QpOworCWlmICghbGxpc3RfZW1wdHkoJmMtPndhaXRp
bmdfZm9yX2dwX3R0cmFjZSkpCisJCXByX3dhcm4oImxlYWs6IHdhaXRpbmdfZm9yX2dwX3R0
cmFjZSAlZFxuIiwgZGlyZWN0KTsKKwlpZiAoIWxsaXN0X2VtcHR5KCZjLT5mcmVlX2xsaXN0
KSkKKwkJcHJfd2FybigibGVhazogZnJlZV9sbGlzdCAlZFxuIiwgZGlyZWN0KTsKKwlpZiAo
IWxsaXN0X2VtcHR5KCZjLT5mcmVlX2xsaXN0X2V4dHJhKSkKKwkJcHJfd2FybigibGVhazog
ZnJlZV9sbGlzdF9leHRyYSAlZFxuIiwgZGlyZWN0KTsKKwlpZiAoIWxsaXN0X2VtcHR5KCZj
LT5mcmVlX2J5X3JjdSkpCisJCXByX3dhcm4oImxlYWs6IGZyZWVfYnlfcmN1ICVkXG4iLCBk
aXJlY3QpOworCWlmICghbGxpc3RfZW1wdHkoJmMtPmZyZWVfbGxpc3RfZXh0cmFfcmN1KSkK
KwkJcHJfd2FybigibGVhazogZnJlZV9sbGlzdF9leHRyYV9yY3UgJWRcbiIsIGRpcmVjdCk7
CisJaWYgKCFsbGlzdF9lbXB0eSgmYy0+d2FpdGluZ19mb3JfZ3ApKQorCQlwcl93YXJuKCJs
ZWFrOiB3YWl0aW5nX2Zvcl9ncCAlZFxuIiwgZGlyZWN0KTsKK30KKworc3RhdGljIHZvaWQg
Y2hlY2tfbGVha2VkX29ianMoc3RydWN0IGJwZl9tZW1fYWxsb2MgKm1hLCBib29sIGRpcmVj
dCkKIHsKKwlzdHJ1Y3QgYnBmX21lbV9jYWNoZXMgKmNjOworCXN0cnVjdCBicGZfbWVtX2Nh
Y2hlICpjOworCWludCBjcHUsIGk7CisKKwlpZiAobWEtPmNhY2hlKSB7CisJCWZvcl9lYWNo
X3Bvc3NpYmxlX2NwdShjcHUpIHsKKwkJCWMgPSBwZXJfY3B1X3B0cihtYS0+Y2FjaGUsIGNw
dSk7CisJCQljaGVja19tZW1fY2FjaGUoYywgZGlyZWN0KTsKKwkJfQorCX0KKwlpZiAobWEt
PmNhY2hlcykgeworCQlmb3JfZWFjaF9wb3NzaWJsZV9jcHUoY3B1KSB7CisJCQljYyA9IHBl
cl9jcHVfcHRyKG1hLT5jYWNoZXMsIGNwdSk7CisJCQlmb3IgKGkgPSAwOyBpIDwgTlVNX0NB
Q0hFUzsgaSsrKSB7CisJCQkJYyA9ICZjYy0+Y2FjaGVbaV07CisJCQkJY2hlY2tfbWVtX2Nh
Y2hlKGMsIGRpcmVjdCk7CisJCQl9CisJCX0KKwl9Cit9CisKK3N0YXRpYyB2b2lkIGZyZWVf
bWVtX2FsbG9jX25vX2JhcnJpZXIoc3RydWN0IGJwZl9tZW1fYWxsb2MgKm1hLCBib29sIGRp
cmVjdCkKK3sKKwljaGVja19sZWFrZWRfb2JqcyhtYSwgZGlyZWN0KTsKIAlmcmVlX3BlcmNw
dShtYS0+Y2FjaGUpOwogCWZyZWVfcGVyY3B1KG1hLT5jYWNoZXMpOwogCW1hLT5jYWNoZSA9
IE5VTEw7CkBAIC01ODksNyArNjMxLDcgQEAgc3RhdGljIHZvaWQgZnJlZV9tZW1fYWxsb2Mo
c3RydWN0IGJwZl9tZW1fYWxsb2MgKm1hKQogCXJjdV9iYXJyaWVyX3Rhc2tzX3RyYWNlKCk7
IC8qIHdhaXQgZm9yIF9fZnJlZV9yY3UgKi8KIAlpZiAoIXJjdV90cmFjZV9pbXBsaWVzX3Jj
dV9ncCgpKQogCQlyY3VfYmFycmllcigpOwotCWZyZWVfbWVtX2FsbG9jX25vX2JhcnJpZXIo
bWEpOworCWZyZWVfbWVtX2FsbG9jX25vX2JhcnJpZXIobWEsIGZhbHNlKTsKIH0KIAogc3Rh
dGljIHZvaWQgZnJlZV9tZW1fYWxsb2NfZGVmZXJyZWQoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQpAQCAtNjA4LDcgKzY1MCw3IEBAIHN0YXRpYyB2b2lkIGRlc3Ryb3lfbWVtX2FsbG9j
KHN0cnVjdCBicGZfbWVtX2FsbG9jICptYSwgaW50IHJjdV9pbl9wcm9ncmVzcykKIAkJLyog
RmFzdCBwYXRoLiBObyBjYWxsYmFja3MgYXJlIHBlbmRpbmcsIGhlbmNlIG5vIG5lZWQgdG8g
ZG8KIAkJICogcmN1X2JhcnJpZXItcy4KIAkJICovCi0JCWZyZWVfbWVtX2FsbG9jX25vX2Jh
cnJpZXIobWEpOworCQlmcmVlX21lbV9hbGxvY19ub19iYXJyaWVyKG1hLCB0cnVlKTsKIAkJ
cmV0dXJuOwogCX0KIAotLSAKMi4zOS4yCgo=
--------------C6B3E9B949ACD7FCEA0E01C3--


