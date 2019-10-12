Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21399D4DE2
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2019 09:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfJLHT0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Oct 2019 03:19:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34483 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfJLHT0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Oct 2019 03:19:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id y135so10806094wmc.1
        for <bpf@vger.kernel.org>; Sat, 12 Oct 2019 00:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+eCPexIO2u4tqVE9lLQfRRt4J1YhGtqfoXSHLQzoe4E=;
        b=OMJ0irXBYNrqMF6vci+duzYryQd0obPEa69MOELfglSUgoa9yAexM5X42nKbbDgCYq
         eDlXn0vrqx6nFRsVa0lkQwgT3is9KjRMgY5umeaGBVlUTZvg0jC5oiZoE/pgZ61WLvCY
         fNG1Y86iob0Y5JCWLT6GXASIcztP8qyGKrAX5Rk1YGoTe1cg5Je6JqvIivIBTEzAf8aV
         ASBrnrlbOIBoSnm8MRQJk9F1qNnlrpjMsmCiT/xFVzxrKyVghm23s3DDQ2w0iO93ii6c
         R0PDisnKOHsBaHLIGeBigJRGifCnEpPe+Db7lZ+7IOGjA6MYy2+GG5b9gENjQEjZSibG
         rrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+eCPexIO2u4tqVE9lLQfRRt4J1YhGtqfoXSHLQzoe4E=;
        b=qwHA6BQIJMfPBbJTUs+4papoy05aZKTwMxBpvz17UYtHsgQUl6UVUhb+dfdxhCmrEO
         K7trnNSfrYgtlaZCkTYx6Kl1/XRmOiMfo6Xgq1Ed8EI1feTBT0fjfhWZdwtzrmbWMfUa
         H5IOFnEWIPQyJvzyUDEvk4KQ6lr87dnlBV+erQtzNbPMifQ6VUKOhVPDfZtxALn5Vsfr
         Lir4JGo1ZlGUSPq0Y7vbZ+scbVwlewibnGOoryABK7ka901+x84+tlZaJJ7MtWVJPg3m
         AgmgHaLdf/GaNSgr2EDasUfVMQgEg9TZ4GRAq9Jk1KIvonF3YSQVDRV+87I5rpZDhrew
         ZEFg==
X-Gm-Message-State: APjAAAVfKzRc0BtOiUlaiupJBNj81a11YbKt/iDHYSsrqFcG51BaxydD
        2C29jlcVjSyu5NNcjMZ9KtaDLQ==
X-Google-Smtp-Source: APXvYqxGGak0oqRfkOFWLhd3KDP7/Axe+f3talCnSGCxJxQlf/yTKU72pCEX//+Ism+EQd+o9gI62g==
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr6567516wmf.142.1570864760935;
        Sat, 12 Oct 2019 00:19:20 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v6sm21992949wma.24.2019.10.12.00.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Oct 2019 00:19:20 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, yhs@fb.com
Cc:     bpf@vger.kernel.org, oss-drivers@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [LLVM PATCH] bpf: fix wrong truncation elimination when there is back-edge/loop
Date:   Sat, 12 Oct 2019 08:18:59 +0100
Message-Id: <1570864740-16857-1-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, BPF backend is doing truncation elimination. If one truncation
is performed on a value defined by narrow loads, then it could be redundant
given BPF loads zero extend the destination register implicitly.

When the definition of the truncated value is a merging value (PHI node)
that could come from different code paths, then checks need to be done on
all possible code paths.

Above described optimization was introduced as r306685, however it doesn't
work when there is back-edge, for example when loop is used inside BPF
code.

For example for the following code, a zero-extended value should be stored
into b[i], but the "and reg, 0xffff" is wrongly eliminated which then
generates corrupted data.

void cal1(unsigned short *a, unsigned long *b, unsigned int k)
{
  unsigned short e;

  e = *a;
  for (unsigned int i = 0; i < k; i++) {
    b[i] = e;
    e = ~e;
  }
}

The reason is r306685 was trying to do the PHI node checks inside isel
DAG2DAG phase, and the checks are done on MachineInstr. This is actually
wrong, because MachineInstr is being built during isel phase and the
associated information is not completed yet. A quick search shows none
target other than BPF is access MachineInstr info during isel phase.

For an PHI node, when you reached it during isel phase, it may have all
predecessors linked, but not successors. It seems successors are linked to
PHI node only when doing SelectionDAGISel::FinishBasicBlock and this
happens later than PreprocessISelDAG hook.

Previously, BPF program doesn't allow loop, there is probably the reason
why this bug was not exposed.

This patch therefore fixes the bug by the following approach:
 - The existing truncation elimination code and the associated
   "load_to_vreg_" records are removed.
 - Instead, implement truncation elimination using MachineSSA pass, this
   is where all information are built, and keep the pass together with other
   similar peephole optimizations inside BPFMIPeephole.cpp. Redundant move
   elimination logic is updated accordingly.
 - Unit testcase included + no compilation errors for kernel BPF selftest.

Reported-by: David Beckett <david.beckett@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 lib/Target/BPF/BPF.h                  |   2 +
 lib/Target/BPF/BPFISelDAGToDAG.cpp    | 169 +++---------------------------
 lib/Target/BPF/BPFMIPeephole.cpp      | 187 +++++++++++++++++++++++++++++++++-
 lib/Target/BPF/BPFTargetMachine.cpp   |  12 ++-
 test/CodeGen/BPF/remove_truncate_6.ll |  80 +++++++++++++++
 5 files changed, 283 insertions(+), 167 deletions(-)
 create mode 100644 test/CodeGen/BPF/remove_truncate_6.ll

diff --git a/lib/Target/BPF/BPF.h b/lib/Target/BPF/BPF.h
index ba21503..6e4f35f 100644
--- a/lib/Target/BPF/BPF.h
+++ b/lib/Target/BPF/BPF.h
@@ -20,12 +20,14 @@ ModulePass *createBPFAbstractMemberAccess(BPFTargetMachine *TM);
 FunctionPass *createBPFISelDag(BPFTargetMachine &TM);
 FunctionPass *createBPFMISimplifyPatchablePass();
 FunctionPass *createBPFMIPeepholePass();
+FunctionPass *createBPFMIPeepholeTruncElimPass();
 FunctionPass *createBPFMIPreEmitPeepholePass();
 FunctionPass *createBPFMIPreEmitCheckingPass();
 
 void initializeBPFAbstractMemberAccessPass(PassRegistry&);
 void initializeBPFMISimplifyPatchablePass(PassRegistry&);
 void initializeBPFMIPeepholePass(PassRegistry&);
+void initializeBPFMIPeepholeTruncElimPass(PassRegistry&);
 void initializeBPFMIPreEmitPeepholePass(PassRegistry&);
 void initializeBPFMIPreEmitCheckingPass(PassRegistry&);
 }
diff --git a/lib/Target/BPF/BPFISelDAGToDAG.cpp b/lib/Target/BPF/BPFISelDAGToDAG.cpp
index 85fa1f2..f2be0ff 100644
--- a/lib/Target/BPF/BPFISelDAGToDAG.cpp
+++ b/lib/Target/BPF/BPFISelDAGToDAG.cpp
@@ -45,9 +45,7 @@ class BPFDAGToDAGISel : public SelectionDAGISel {
 
 public:
   explicit BPFDAGToDAGISel(BPFTargetMachine &TM)
-      : SelectionDAGISel(TM), Subtarget(nullptr) {
-    curr_func_ = nullptr;
-  }
+      : SelectionDAGISel(TM), Subtarget(nullptr) {}
 
   StringRef getPassName() const override {
     return "BPF DAG->DAG Pattern Instruction Selection";
@@ -92,14 +90,8 @@ private:
                           val_vec_type &Vals, int Offset);
   bool getConstantFieldValue(const GlobalAddressSDNode *Node, uint64_t Offset,
                              uint64_t Size, unsigned char *ByteSeq);
-  bool checkLoadDef(unsigned DefReg, unsigned match_load_op);
-
   // Mapping from ConstantStruct global value to corresponding byte-list values
   std::map<const void *, val_vec_type> cs_vals_;
-  // Mapping from vreg to load memory opcode
-  std::map<unsigned, unsigned> load_to_vreg_;
-  // Current function
-  const Function *curr_func_;
 };
 } // namespace
 
@@ -325,32 +317,13 @@ void BPFDAGToDAGISel::PreprocessLoad(SDNode *Node,
 }
 
 void BPFDAGToDAGISel::PreprocessISelDAG() {
-  // Iterate through all nodes, interested in the following cases:
+  // Iterate through all nodes, interested in the following case:
   //
   //  . loads from ConstantStruct or ConstantArray of constructs
   //    which can be turns into constant itself, with this we can
   //    avoid reading from read-only section at runtime.
   //
-  //  . reg truncating is often the result of 8/16/32bit->64bit or
-  //    8/16bit->32bit conversion. If the reg value is loaded with
-  //    masked byte width, the AND operation can be removed since
-  //    BPF LOAD already has zero extension.
-  //
-  //    This also solved a correctness issue.
-  //    In BPF socket-related program, e.g., __sk_buff->{data, data_end}
-  //    are 32-bit registers, but later on, kernel verifier will rewrite
-  //    it with 64-bit value. Therefore, truncating the value after the
-  //    load will result in incorrect code.
-
-  // clear the load_to_vreg_ map so that we have a clean start
-  // for this function.
-  if (!curr_func_) {
-    curr_func_ = FuncInfo->Fn;
-  } else if (curr_func_ != FuncInfo->Fn) {
-    load_to_vreg_.clear();
-    curr_func_ = FuncInfo->Fn;
-  }
-
+  //  . Removing redundant AND for intrinsic narrow loads.
   for (SelectionDAG::allnodes_iterator I = CurDAG->allnodes_begin(),
                                        E = CurDAG->allnodes_end();
        I != E;) {
@@ -358,8 +331,6 @@ void BPFDAGToDAGISel::PreprocessISelDAG() {
     unsigned Opcode = Node->getOpcode();
     if (Opcode == ISD::LOAD)
       PreprocessLoad(Node, I);
-    else if (Opcode == ISD::CopyToReg)
-      PreprocessCopyToReg(Node);
     else if (Opcode == ISD::AND)
       PreprocessTrunc(Node, I);
   }
@@ -491,36 +462,6 @@ bool BPFDAGToDAGISel::fillConstantStruct(const DataLayout &DL,
   return true;
 }
 
-void BPFDAGToDAGISel::PreprocessCopyToReg(SDNode *Node) {
-  const RegisterSDNode *RegN = dyn_cast<RegisterSDNode>(Node->getOperand(1));
-  if (!RegN || !Register::isVirtualRegister(RegN->getReg()))
-    return;
-
-  const LoadSDNode *LD = dyn_cast<LoadSDNode>(Node->getOperand(2));
-  if (!LD)
-    return;
-
-  // Assign a load value to a virtual register. record its load width
-  unsigned mem_load_op = 0;
-  switch (LD->getMemOperand()->getSize()) {
-  default:
-    return;
-  case 4:
-    mem_load_op = BPF::LDW;
-    break;
-  case 2:
-    mem_load_op = BPF::LDH;
-    break;
-  case 1:
-    mem_load_op = BPF::LDB;
-    break;
-  }
-
-  LLVM_DEBUG(dbgs() << "Find Load Value to VReg "
-                    << Register::virtReg2Index(RegN->getReg()) << '\n');
-  load_to_vreg_[RegN->getReg()] = mem_load_op;
-}
-
 void BPFDAGToDAGISel::PreprocessTrunc(SDNode *Node,
                                       SelectionDAG::allnodes_iterator &I) {
   ConstantSDNode *MaskN = dyn_cast<ConstantSDNode>(Node->getOperand(1));
@@ -534,112 +475,26 @@ void BPFDAGToDAGISel::PreprocessTrunc(SDNode *Node,
   // which the generic optimizer doesn't understand their results are
   // zero extended.
   SDValue BaseV = Node->getOperand(0);
-  if (BaseV.getOpcode() == ISD::INTRINSIC_W_CHAIN) {
-    unsigned IntNo = cast<ConstantSDNode>(BaseV->getOperand(1))->getZExtValue();
-    uint64_t MaskV = MaskN->getZExtValue();
-
-    if (!((IntNo == Intrinsic::bpf_load_byte && MaskV == 0xFF) ||
-          (IntNo == Intrinsic::bpf_load_half && MaskV == 0xFFFF) ||
-          (IntNo == Intrinsic::bpf_load_word && MaskV == 0xFFFFFFFF)))
-      return;
-
-    LLVM_DEBUG(dbgs() << "Remove the redundant AND operation in: ";
-               Node->dump(); dbgs() << '\n');
-
-    I--;
-    CurDAG->ReplaceAllUsesWith(SDValue(Node, 0), BaseV);
-    I++;
-    CurDAG->DeleteNode(Node);
-
-    return;
-  }
-
-  // Multiple basic blocks case.
-  if (BaseV.getOpcode() != ISD::CopyFromReg)
+  if (BaseV.getOpcode() != ISD::INTRINSIC_W_CHAIN)
     return;
 
-  unsigned match_load_op = 0;
-  switch (MaskN->getZExtValue()) {
-  default:
-    return;
-  case 0xFFFFFFFF:
-    match_load_op = BPF::LDW;
-    break;
-  case 0xFFFF:
-    match_load_op = BPF::LDH;
-    break;
-  case 0xFF:
-    match_load_op = BPF::LDB;
-    break;
-  }
+  unsigned IntNo = cast<ConstantSDNode>(BaseV->getOperand(1))->getZExtValue();
+  uint64_t MaskV = MaskN->getZExtValue();
 
-  const RegisterSDNode *RegN =
-      dyn_cast<RegisterSDNode>(BaseV.getNode()->getOperand(1));
-  if (!RegN || !Register::isVirtualRegister(RegN->getReg()))
+  if (!((IntNo == Intrinsic::bpf_load_byte && MaskV == 0xFF) ||
+        (IntNo == Intrinsic::bpf_load_half && MaskV == 0xFFFF) ||
+        (IntNo == Intrinsic::bpf_load_word && MaskV == 0xFFFFFFFF)))
     return;
-  unsigned AndOpReg = RegN->getReg();
-  LLVM_DEBUG(dbgs() << "Examine " << printReg(AndOpReg) << '\n');
-
-  // Examine the PHI insns in the MachineBasicBlock to found out the
-  // definitions of this virtual register. At this stage (DAG2DAG
-  // transformation), only PHI machine insns are available in the machine basic
-  // block.
-  MachineBasicBlock *MBB = FuncInfo->MBB;
-  MachineInstr *MII = nullptr;
-  for (auto &MI : *MBB) {
-    for (unsigned i = 0; i < MI.getNumOperands(); ++i) {
-      const MachineOperand &MOP = MI.getOperand(i);
-      if (!MOP.isReg() || !MOP.isDef())
-        continue;
-      Register Reg = MOP.getReg();
-      if (Register::isVirtualRegister(Reg) && Reg == AndOpReg) {
-        MII = &MI;
-        break;
-      }
-    }
-  }
-
-  if (MII == nullptr) {
-    // No phi definition in this block.
-    if (!checkLoadDef(AndOpReg, match_load_op))
-      return;
-  } else {
-    // The PHI node looks like:
-    //   %2 = PHI %0, <%bb.1>, %1, <%bb.3>
-    // Trace each incoming definition, e.g., (%0, %bb.1) and (%1, %bb.3)
-    // The AND operation can be removed if both %0 in %bb.1 and %1 in
-    // %bb.3 are defined with a load matching the MaskN.
-    LLVM_DEBUG(dbgs() << "Check PHI Insn: "; MII->dump(); dbgs() << '\n');
-    unsigned PrevReg = -1;
-    for (unsigned i = 0; i < MII->getNumOperands(); ++i) {
-      const MachineOperand &MOP = MII->getOperand(i);
-      if (MOP.isReg()) {
-        if (MOP.isDef())
-          continue;
-        PrevReg = MOP.getReg();
-        if (!Register::isVirtualRegister(PrevReg))
-          return;
-        if (!checkLoadDef(PrevReg, match_load_op))
-          return;
-      }
-    }
-  }
 
-  LLVM_DEBUG(dbgs() << "Remove the redundant AND operation in: "; Node->dump();
-             dbgs() << '\n');
+  LLVM_DEBUG(dbgs() << "Remove the redundant AND operation in: ";
+             Node->dump(); dbgs() << '\n');
 
   I--;
   CurDAG->ReplaceAllUsesWith(SDValue(Node, 0), BaseV);
   I++;
   CurDAG->DeleteNode(Node);
-}
-
-bool BPFDAGToDAGISel::checkLoadDef(unsigned DefReg, unsigned match_load_op) {
-  auto it = load_to_vreg_.find(DefReg);
-  if (it == load_to_vreg_.end())
-    return false; // The definition of register is not exported yet.
 
-  return it->second == match_load_op;
+  return;
 }
 
 FunctionPass *llvm::createBPFISelDag(BPFTargetMachine &TM) {
diff --git a/lib/Target/BPF/BPFMIPeephole.cpp b/lib/Target/BPF/BPFMIPeephole.cpp
index fafd2f7..2b52ce0 100644
--- a/lib/Target/BPF/BPFMIPeephole.cpp
+++ b/lib/Target/BPF/BPFMIPeephole.cpp
@@ -71,7 +71,7 @@ void BPFMIPeephole::initialize(MachineFunction &MFParm) {
   MF = &MFParm;
   MRI = &MF->getRegInfo();
   TII = MF->getSubtarget<BPFSubtarget>().getInstrInfo();
-  LLVM_DEBUG(dbgs() << "*** BPF MachineSSA peephole pass ***\n\n");
+  LLVM_DEBUG(dbgs() << "*** BPF MachineSSA ZEXT Elim peephole pass ***\n\n");
 }
 
 bool BPFMIPeephole::isMovFrom32Def(MachineInstr *MovMI)
@@ -186,7 +186,8 @@ bool BPFMIPeephole::eliminateZExtSeq(void) {
 } // end default namespace
 
 INITIALIZE_PASS(BPFMIPeephole, DEBUG_TYPE,
-                "BPF MachineSSA Peephole Optimization", false, false)
+                "BPF MachineSSA Peephole Optimization For ZEXT Eliminate",
+                false, false)
 
 char BPFMIPeephole::ID = 0;
 FunctionPass* llvm::createBPFMIPeepholePass() { return new BPFMIPeephole(); }
@@ -253,12 +254,16 @@ bool BPFMIPreEmitPeephole::eliminateRedundantMov(void) {
       // enabled. The special type cast insn MOV_32_64 involves different
       // register class on src (i32) and dst (i64), RA could generate useless
       // instruction due to this.
-      if (MI.getOpcode() == BPF::MOV_32_64) {
+      unsigned Opcode = MI.getOpcode();
+      if (Opcode == BPF::MOV_32_64 ||
+          Opcode == BPF::MOV_rr || Opcode == BPF::MOV_rr_32) {
         Register dst = MI.getOperand(0).getReg();
-        Register dst_sub = TRI->getSubReg(dst, BPF::sub_32);
         Register src = MI.getOperand(1).getReg();
 
-        if (dst_sub != src)
+        if (Opcode == BPF::MOV_32_64)
+          dst = TRI->getSubReg(dst, BPF::sub_32);
+
+        if (dst != src)
           continue;
 
         ToErase = &MI;
@@ -281,3 +286,175 @@ FunctionPass* llvm::createBPFMIPreEmitPeepholePass()
 {
   return new BPFMIPreEmitPeephole();
 }
+
+STATISTIC(TruncElemNum, "Number of truncation eliminated");
+
+namespace {
+
+struct BPFMIPeepholeTruncElim : public MachineFunctionPass {
+
+  static char ID;
+  const BPFInstrInfo *TII;
+  MachineFunction *MF;
+  MachineRegisterInfo *MRI;
+
+  BPFMIPeepholeTruncElim() : MachineFunctionPass(ID) {
+    initializeBPFMIPeepholeTruncElimPass(*PassRegistry::getPassRegistry());
+  }
+
+private:
+  // Initialize class variables.
+  void initialize(MachineFunction &MFParm);
+
+  bool eliminateTruncSeq(void);
+
+public:
+
+  // Main entry point for this pass.
+  bool runOnMachineFunction(MachineFunction &MF) override {
+    if (skipFunction(MF.getFunction()))
+      return false;
+
+    initialize(MF);
+
+    return eliminateTruncSeq();
+  }
+};
+
+static bool TruncSizeCompatible(int TruncSize, unsigned opcode)
+{
+  if (TruncSize == 1)
+    return opcode == BPF::LDB || opcode == BPF::LDB32;
+
+  if (TruncSize == 2)
+    return opcode == BPF::LDH || opcode == BPF::LDH32;
+
+  if (TruncSize == 4)
+    return opcode == BPF::LDW || opcode == BPF::LDW32;
+
+  return false;
+}
+
+// Initialize class variables.
+void BPFMIPeepholeTruncElim::initialize(MachineFunction &MFParm) {
+  MF = &MFParm;
+  MRI = &MF->getRegInfo();
+  TII = MF->getSubtarget<BPFSubtarget>().getInstrInfo();
+  LLVM_DEBUG(dbgs() << "*** BPF MachineSSA TRUNC Elim peephole pass ***\n\n");
+}
+
+// Reg truncating is often the result of 8/16/32bit->64bit or
+// 8/16bit->32bit conversion. If the reg value is loaded with
+// masked byte width, the AND operation can be removed since
+// BPF LOAD already has zero extension.
+//
+// This also solved a correctness issue.
+// In BPF socket-related program, e.g., __sk_buff->{data, data_end}
+// are 32-bit registers, but later on, kernel verifier will rewrite
+// it with 64-bit value. Therefore, truncating the value after the
+// load will result in incorrect code.
+bool BPFMIPeepholeTruncElim::eliminateTruncSeq(void) {
+  MachineInstr* ToErase = nullptr;
+  bool Eliminated = false;
+
+  for (MachineBasicBlock &MBB : *MF) {
+    for (MachineInstr &MI : MBB) {
+      // The second insn to remove if the eliminate candidate is a pair.
+      MachineInstr *MI2 = nullptr;;
+      Register DstReg, SrcReg;
+      MachineInstr *DefMI;
+      int TruncSize = -1;
+
+      // If the previous instruction was marked for elimination, remove it now.
+      if (ToErase) {
+        ToErase->eraseFromParent();
+        ToErase = nullptr;
+      }
+
+      // AND A, 0xFFFFFFFF will be turned into SLL/SRL pair due to immediate
+      // for BPF ANDI is i32, and this case only happens on ALU64.
+      if (MI.getOpcode() == BPF::SRL_ri &&
+          MI.getOperand(2).getImm() == 32) {
+        SrcReg = MI.getOperand(1).getReg();
+        MI2 = MRI->getVRegDef(SrcReg);
+        DstReg = MI.getOperand(0).getReg();
+
+        if (!MI2 ||
+            MI2->getOpcode() != BPF::SLL_ri ||
+            MI2->getOperand(2).getImm() != 32)
+          continue;
+
+        // Update SrcReg.
+        SrcReg = MI2->getOperand(1).getReg();
+        DefMI = MRI->getVRegDef(SrcReg);
+        if (DefMI)
+          TruncSize = 4;
+      } else if (MI.getOpcode() == BPF::AND_ri ||
+                 MI.getOpcode() == BPF::AND_ri_32) {
+        SrcReg = MI.getOperand(1).getReg();
+        DstReg = MI.getOperand(0).getReg();
+        DefMI = MRI->getVRegDef(SrcReg);
+
+        if (!DefMI)
+          continue;
+
+        int64_t imm = MI.getOperand(2).getImm();
+        if (imm == 0xff)
+          TruncSize = 1;
+        else if (imm == 0xffff)
+          TruncSize = 2;
+      }
+
+      if (TruncSize == -1)
+        continue;
+
+      // The definition is PHI node, check all inputs.
+      if (DefMI->isPHI()) {
+        bool CheckFail = false;
+
+        for (unsigned i = 1, e = DefMI->getNumOperands(); i < e; i += 2) {
+          MachineOperand &opnd = DefMI->getOperand(i);
+          if (!opnd.isReg())
+            return false;
+
+          MachineInstr *PhiDef = MRI->getVRegDef(opnd.getReg());
+          if (!PhiDef || PhiDef->isPHI() ||
+              !TruncSizeCompatible(TruncSize, PhiDef->getOpcode())) {
+            CheckFail = true;
+            break;
+          }
+        }
+
+        if (CheckFail)
+          continue;
+      } else if (!TruncSizeCompatible(TruncSize, DefMI->getOpcode())) {
+        continue;
+      }
+
+      BuildMI(MBB, MI, MI.getDebugLoc(), TII->get(BPF::MOV_rr), DstReg)
+              .addReg(SrcReg);
+
+      if (MI2)
+        MI2->eraseFromParent();
+
+      // Mark it to ToErase, and erase in the next iteration.
+      ToErase = &MI;
+      TruncElemNum++;
+      Eliminated = true;
+    }
+  }
+
+  return Eliminated;
+}
+
+} // end default namespace
+
+INITIALIZE_PASS(BPFMIPeepholeTruncElim, "bpf-mi-trunc-elim",
+                "BPF MachineSSA Peephole Optimization For TRUNC Eliminate",
+                false, false)
+
+char BPFMIPeepholeTruncElim::ID = 0;
+FunctionPass* llvm::createBPFMIPeepholeTruncElimPass()
+{
+  return new BPFMIPeepholeTruncElim();
+}
diff --git a/lib/Target/BPF/BPFTargetMachine.cpp b/lib/Target/BPF/BPFTargetMachine.cpp
index d940ac9..0c4f2c7 100644
--- a/lib/Target/BPF/BPFTargetMachine.cpp
+++ b/lib/Target/BPF/BPFTargetMachine.cpp
@@ -36,6 +36,7 @@ extern "C" void LLVMInitializeBPFTarget() {
   PassRegistry &PR = *PassRegistry::getPassRegistry();
   initializeBPFAbstractMemberAccessPass(PR);
   initializeBPFMIPeepholePass(PR);
+  initializeBPFMIPeepholeTruncElimPass(PR);
 }
 
 // DataLayout: little or big endian
@@ -115,15 +116,16 @@ void BPFPassConfig::addMachineSSAOptimization() {
   TargetPassConfig::addMachineSSAOptimization();
 
   const BPFSubtarget *Subtarget = getBPFTargetMachine().getSubtargetImpl();
-  if (Subtarget->getHasAlu32() && !DisableMIPeephole)
-    addPass(createBPFMIPeepholePass());
+  if (!DisableMIPeephole) {
+    if (Subtarget->getHasAlu32())
+      addPass(createBPFMIPeepholePass());
+    addPass(createBPFMIPeepholeTruncElimPass());
+  }
 }
 
 void BPFPassConfig::addPreEmitPass() {
-  const BPFSubtarget *Subtarget = getBPFTargetMachine().getSubtargetImpl();
-
   addPass(createBPFMIPreEmitCheckingPass());
   if (getOptLevel() != CodeGenOpt::None)
-    if (Subtarget->getHasAlu32() && !DisableMIPeephole)
+    if (!DisableMIPeephole)
       addPass(createBPFMIPreEmitPeepholePass());
 }
diff --git a/test/CodeGen/BPF/remove_truncate_6.ll b/test/CodeGen/BPF/remove_truncate_6.ll
new file mode 100644
index 0000000..6577afb
--- /dev/null
+++ b/test/CodeGen/BPF/remove_truncate_6.ll
@@ -0,0 +1,80 @@
+; RUN: llc < %s -march=bpf -verify-machineinstrs | FileCheck %s
+; RUN: llc < %s -march=bpf -mattr=+alu32 -verify-machineinstrs | FileCheck --check-prefix=CHECK-32 %s
+;
+; void cal1(unsigned short *a, unsigned long *b, unsigned int k)
+; {
+;   unsigned short e;
+;
+;   e = *a;
+;   for (unsigned int i = 0; i < k; i++) {
+;     b[i] = e;
+;     e = ~e;
+;   }
+; }
+;
+; void cal2(unsigned short *a, unsigned int *b, unsigned int k)
+; {
+;   unsigned short e;
+;
+;   e = *a;
+;   for (unsigned int i = 0; i < k; i++) {
+;     b[i] = e;
+;     e = ~e;
+;   }
+; }
+
+; Function Attrs: nofree norecurse nounwind optsize
+define dso_local void @cal1(i16* nocapture readonly %a, i64* nocapture %b, i32 %k) local_unnamed_addr #0 {
+entry:
+  %cmp8 = icmp eq i32 %k, 0
+  br i1 %cmp8, label %for.cond.cleanup, label %for.body.preheader
+
+for.body.preheader:                               ; preds = %entry
+  %0 = load i16, i16* %a, align 2
+  %wide.trip.count = zext i32 %k to i64
+  br label %for.body
+
+for.cond.cleanup:                                 ; preds = %for.body, %entry
+  ret void
+
+for.body:                                         ; preds = %for.body, %for.body.preheader
+  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
+  %e.09 = phi i16 [ %0, %for.body.preheader ], [ %neg, %for.body ]
+  %conv = zext i16 %e.09 to i64
+  %arrayidx = getelementptr inbounds i64, i64* %b, i64 %indvars.iv
+; CHECK: r{{[0-9]+}} &= 65535
+; CHECK-32: r{{[0-9]+}} &= 65535
+  store i64 %conv, i64* %arrayidx, align 8
+  %neg = xor i16 %e.09, -1
+  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
+  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
+  br i1 %exitcond, label %for.cond.cleanup, label %for.body
+}
+
+; Function Attrs: nofree norecurse nounwind optsize
+define dso_local void @cal2(i16* nocapture readonly %a, i32* nocapture %b, i32 %k) local_unnamed_addr #0 {
+entry:
+  %cmp8 = icmp eq i32 %k, 0
+  br i1 %cmp8, label %for.cond.cleanup, label %for.body.preheader
+
+for.body.preheader:                               ; preds = %entry
+  %0 = load i16, i16* %a, align 2
+  %wide.trip.count = zext i32 %k to i64
+  br label %for.body
+
+for.cond.cleanup:                                 ; preds = %for.body, %entry
+  ret void
+
+for.body:                                         ; preds = %for.body, %for.body.preheader
+  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
+  %e.09 = phi i16 [ %0, %for.body.preheader ], [ %neg, %for.body ]
+  %conv = zext i16 %e.09 to i32
+  %arrayidx = getelementptr inbounds i32, i32* %b, i64 %indvars.iv
+; CHECK: r{{[0-9]+}} &= 65535
+; CHECK-32: w{{[0-9]+}} &= 65535
+  store i32 %conv, i32* %arrayidx, align 4
+  %neg = xor i16 %e.09, -1
+  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
+  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
+  br i1 %exitcond, label %for.cond.cleanup, label %for.body
+}
-- 
2.7.4

